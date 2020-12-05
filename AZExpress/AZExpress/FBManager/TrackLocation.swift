//
//  TrackLocation.swift
//  AZExpress
//
//  Created by TaNhi on 6/5/20.
//  Copyright © 2020 Duc Chinh. All rights reserved.
//

import Foundation
import FirebaseDatabase

class TrackLocation {
    static let shared = TrackLocation()
    private let databaseRef: DatabaseReference
    
    
    
    deinit {
    }
    
    init() {
        databaseRef = FirebaseService.shared.databaseRef();
        
    }
    
    
    func trackLocationsRef() -> DatabaseReference? {
        return databaseRef.child("track")
    }
    
    func trackLocation(_ location: LocationTrackModel) {
        let dic: [String: Any] = ["long": location.long,
                                  "lat": location.lat,
                                  "date": ServerValue.timestamp()]
        
//        let deviceId = UIDevice.current.identifierForVendor?.uuidString ?? "unkown\(UUID().uuidString)"
//        trackLocationsRef()?.child(deviceId).childByAutoId().setValue(dic)
        trackLocationsRef()?.child("userID").child("taskID").setValue(dic)
    }
    
}
