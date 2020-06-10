//
//  CaptureVC.swift
//  AZExpress
//
//  Created by Phung Duc Chinh on 6/6/20.
//  Copyright © 2020 Duc Chinh. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import CameraManager
import SVProgressHUD

class CaptureVC: BaseVC {

    @IBOutlet weak var imvCapture: UIImageView!
    @IBOutlet weak var btnCapture: UIButton!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblDateTime: UILabel!
    @IBOutlet weak var vwMap: MKMapView!
    @IBOutlet weak var vwRender: UIView!
    
    let locationManager         = CLLocationManager()
    var location                = CLLocation()
    let cameraManager           = CameraManager()
    var jobVM =  JobViewModel()
    var jobID = ""
    var parentVC: JobDetailVC?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingView()
        // Do any additional setup after loading the view.
    }
    
    func settingView(){
        vwMap.isUserInteractionEnabled = false
        cameraManager.cameraDevice = .back
        cameraManager.addPreviewLayerToView(self.imvCapture)
        
        self.locationManager.requestAlwaysAuthorization()

        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }

        vwMap.delegate = self
        vwMap.mapType = .standard
        vwMap.isZoomEnabled = false
        vwMap.isScrollEnabled = false
        if let coor = vwMap.userLocation.location?.coordinate{
            let viewRegion = MKCoordinateRegion(center: coor, latitudinalMeters: 300, longitudinalMeters: 300)
            vwMap.setRegion(viewRegion, animated: true)
        }
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm dd-MM-yyyy"
        let result = formatter.string(from: date)
        lblDateTime.text = result
    }

    @IBAction func onActionCapture(_ sender: Any) {
        let renderer = UIGraphicsImageRenderer(size: vwRender.bounds.size)
        let image = renderer.image { ctx in
            vwRender.drawHierarchy(in: vwRender.bounds, afterScreenUpdates: true)
        }
        SVProgressHUD.show()
        cameraManager.capturePictureWithCompletion({ result in
            switch result {
            case .failure:
                // error handling
                SVProgressHUD.dismiss()
                print("fail")
            case .success(let content):
                print("success", content.asImage?.description as Any)
                //content.asImage!
                
                if image.pngData() != nil, let bgImage : UIImage = content.asImage {
                    let compressImg = self.mergedImageWith(frontImage: image, backgroundImage: bgImage, size: self.imvCapture.frame.size)
                    self.handelImage(image: compressImg)
                }else{
                    SVProgressHUD.dismiss()
                }
                print(image)
            }
        })
    }
    
    func getAddressFromLatLon(location: CLLocation) -> () {
        let ceo: CLGeocoder = CLGeocoder()
        ceo.reverseGeocodeLocation(location, completionHandler:
            {(placemarks, error) in
                if (error != nil)
                {
                    print("reverse geodcode fail: \(error!.localizedDescription)")
                }
                if let pm : [CLPlacemark] = placemarks, pm.count > 0 {
                    let pm = placemarks![0]
                    var addressString : String = ""
                    if pm.subLocality != nil {
                        addressString = addressString + pm.subLocality! + ", "
                    }
                    if pm.thoroughfare != nil {
                        addressString = addressString + pm.thoroughfare! + ", "
                    }
                    if pm.locality != nil {
                        addressString = addressString + pm.locality! + ", "
                    }
                    if pm.country != nil {
                        addressString = addressString + pm.country! + ", "
                    }
                    //                    if pm.postalCode != nil {
                    //                        addressString = addressString + pm.postalCode! + " "
                    //                    }
                    
                    print(addressString)
                    self.lblLocation.text = addressString
                    return
                }
                
        })

    }
    
    func handelImage(image: UIImage){
        jobVM.updateJobID(data: self.jobID)
        if let photoDataToRequest = image.jpegData(compressionQuality: 0){
//            self.jobVM.upload(image: photoDataToRequest, onCompletion: {data in
//                self.parentVC?.isSendImageSuccess = true
//                SVProgressHUD.dismiss()
//                self.dismissVC(sender: nil)
//            }, onError: { error in
//                SVProgressHUD.dismiss()
//                Alert.shared.showInfo(title: "", message: error.messages, on: self, callback: nil)
//            })
            self.jobVM.uploadV2(image: photoDataToRequest, onCompletion: {data in
                self.parentVC?.isSendImageSuccess = true
                SVProgressHUD.dismiss()
                self.dismissVC(sender: nil)
            }, onError: { error in
                SVProgressHUD.dismiss()
                Alert.shared.showInfo(title: "", message: error.messages, on: self, callback: nil)
            })
        }
    }
}

extension CaptureVC: CLLocationManagerDelegate,MKMapViewDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate

        vwMap.mapType = MKMapType.standard

        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)//MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegion(center: locValue, span: span)
        vwMap.setRegion(region, animated: true)

        let annotation = MKPointAnnotation()
        annotation.coordinate = locValue
        annotation.title = "Vị trí của bạn"
        annotation.subtitle = ""
        vwMap.addAnnotation(annotation)
        self.getAddressFromLatLon(location: manager.location!)
        //centerMap(locValue)
    }
}

//-MARK: Merge image function
extension CaptureVC{
    func mergedImageWith(frontImage:UIImage?, backgroundImage: UIImage?, size: CGSize) -> UIImage{

        if (backgroundImage == nil) {
            return frontImage!
        }

        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)

        backgroundImage?.draw(in: CGRect.init(x: 0, y: 0, width: size.width, height: size.height))
        frontImage?.draw(in: CGRect.init(x: 0, y: size.height - (frontImage?.size.height)!, width: size.width, height: (frontImage?.size.height)!))

        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        return newImage
    }
}
