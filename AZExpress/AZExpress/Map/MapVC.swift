//
//  MapVC.swift
//  AZExpress
//
//  Created by TaNhi on 6/4/20.
//  Copyright © 2020 Duc Chinh. All rights reserved.
//

import Foundation
import UIKit


class MapVC: BaseVC {
    let track = TrackLocation.shared
    
    @IBOutlet weak var lblLocation: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Location"
//
//        var i = 0
//
//        while true {
//            guard i < 10 else { return }
//            i += 1
//
//            let location = LocationTrackModel(lat: 0.11 + Double(i),
//                                              long: 0.22 + Double(i))
//
//            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
//                print("[\(i)]Lat: \(location.lat)\nLong: \(location.long)")
//                self.track.trackLocation(location)
//            }
//        }
    }
}
