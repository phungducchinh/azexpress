//
//  JobDetailVC.swift
//  AZExpress
//
//  Created by Phung Duc Chinh on 6/5/20.
//  Copyright © 2020 Duc Chinh. All rights reserved.
//

import UIKit
import SVProgressHUD
import SDWebImage

class JobDetailVC: BaseVC {
    
    @IBOutlet weak var btnCapture: UIButton!
    @IBOutlet weak var vwFinish: UIView!
    @IBOutlet weak var lblDescript: UILabel!
    @IBOutlet weak var imv: UIImageView!
    @IBOutlet weak var vwStackDate: UIStackView!
    @IBOutlet weak var vwBGImage: UIView!
    
    @IBOutlet weak var lblCode: UILabel!
    @IBOutlet weak var lblCusName: UILabel!
    @IBOutlet weak var lblTransName: UILabel!
    @IBOutlet weak var lblPhone: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblDateTime: UILabel!
    
    
    var jobVM =  JobViewModel()
    var jobID = ""
    var jobType = JobType.new
    var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getData()
    }
    
    func settupView(){
        self.title = "Thông tin công việc"
        btnCapture.setShadow(color: UIColor.black.withAlphaComponent(0.20), x: 0, y: 2, blur: 4)
        
        guard let data = self.jobVM.jobDetail.data else{
            return
        }
        
        self.jobType = self.jobVM.jobDetail.data?.status == "New" ? .new : .finish
        
        switch jobType {
        case .new:
            self.vwFinish.isHidden = true
            self.imv.isHidden = true
            self.vwBGImage.isHidden = true
            self.lblDescript.isHidden = false
            self.btnCapture.isHidden = false
            self.vwStackDate.isHidden = true
        case .finish:
            self.vwFinish.isHidden = false
            self.imv.isHidden = false
            self.vwBGImage.isHidden = false
            self.lblDescript.isHidden = true
            self.btnCapture.isHidden = true
            self.vwStackDate.isHidden = false
        }
        
        
        self.lblCode.text = "Mã QRCode: \(data.task_code ?? "")"
//        self.lblCusName.text = "Mã QRCode: \(data.task_code ?? "")"
//        self.lblTransName.text = "Mã QRCode: \(data.task_code ?? "")"
        self.lblPhone.text = "\(data.phone ?? "")"
        self.lblAddress.text = "\(data.address ?? "")"
        self.lblDateTime.text = "\(data.delivered_at ?? "")"
        
        if let imgText = data.image_url{
            imv.sd_setImage(with: URL(string: imgText), placeholderImage: UIImage(named: "imv_place_holder"))
        }
    }
    
    func getData(){
        guard self.jobID != "" else{
            return
        }
        SVProgressHUD.show()
        jobVM.updateJobID(data: self.jobID)
        jobVM.getJobDetail(onCompletion: {data in
            guard let data = data else{
                SVProgressHUD.dismiss()
                Alert.shared.showInfo(title: "", message: "Có lỗi xảy ra. Vui lòng thử lại", on: self, callback: nil)
                return
            }
            self.jobVM.addJpbDetailData(data: data)
            self.settupView()
            SVProgressHUD.dismiss()
        }, onError: {error in
            SVProgressHUD.dismiss()
            Alert.shared.showInfo(title: "", message: error.messages, on: self, callback: nil)
        })
    }
    
    @IBAction func onActionCapture(_ sender: Any) {
        let captureVC: CaptureVC = CaptureVC.loadFromNib()
        self.presentViewController(captureVC, animated: true)
    }
    
}
