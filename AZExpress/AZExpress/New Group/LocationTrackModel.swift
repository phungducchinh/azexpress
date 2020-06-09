//
//  LocationTrack.swift
//  AZExpress
//
//  Created by TaNhi on 6/5/20.
//  Copyright © 2020 Duc Chinh. All rights reserved.
//

import Foundation
class LocationTrackModel: BaseModel {
    var lat: Double = 0
    var long: Double = 0
    
    init(lat: Double, long: Double) {
        self.lat = lat
        self.long = long
    }
    
    init?(firebase data: [String: Any]) {
        if let lat = data["lat"] as? Double {
            self.lat = lat
        }
        
        if let long = data["long"] as? Double {
            self.long = long
        }
    }
    
    required init?(dictionary: ModelDictionaryRaw, context: ModelContext) {
        return nil
    }
    
    func toDictionary(context: ModelContext) -> ModelDictionaryRaw? {
        return nil
    }

}
