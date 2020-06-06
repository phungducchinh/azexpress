//
//  TrackLocation.swift
//  AZExpress
//
//  Created by TaNhi on 6/5/20.
//  Copyright © 2020 Duc Chinh. All rights reserved.
//

import Foundation
import FirebaseDatabase
import CoreLocation

class TrackLocation {
    static let shared = TrackLocation()
    private let databaseRef: DatabaseReference
    
    let locationManager = CLLocationManager()
    
    deinit {
    }
    
    init() {
        databaseRef = FirebaseService.shared.databaseRef();
        getCurrentLocationOfUser()
    }
    
    func getCurrentLocationOfUser() {
        self.locationManager.requestAlwaysAuthorization()

//        self.locationManager.requestWhenInUseAuthorization()

        if CLLocationManager.locationServicesEnabled() {
//            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
            locationManager(locationManager)
        }
    }
    
    func trackLocationsRef() -> DatabaseReference? {
        return databaseRef.child("track")
    }
    
    func trackLocation(_ location: LocationTrackModel) {
        let dic: [String: Any] = ["long": location.long,
                                  "lat": location.lat,
                                  "date": ServerValue.timestamp()]
        
        let deviceId = UIDevice.current.identifierForVendor?.uuidString ?? "unkown\(UUID().uuidString)"
        trackLocationsRef()?.child(deviceId).childByAutoId().setValue(dic)
    }
    
    func locationManager(_ manager: CLLocationManager) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        
        trackLocation(LocationTrackModel(lat: locValue.latitude, long: locValue.longitude))
    }
}

