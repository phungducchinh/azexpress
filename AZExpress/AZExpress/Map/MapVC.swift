//
//  MapVC.swift
//  AZExpress
//
//  Created by TaNhi on 6/4/20.
//  Copyright © 2020 Duc Chinh. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation


class MapVC: BaseVC {
    let track = TrackLocation.shared
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var lblLocation: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Location"

        getCurrentLocationOfUser()
    }
    
    func getCurrentLocationOfUser() {
        self.locationManager.requestAlwaysAuthorization()
        
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
}

extension MapVC: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        
        let location = LocationTrackModel(lat: locValue.latitude, long: locValue.longitude)
        
        track.trackLocation(location)
    }
}
