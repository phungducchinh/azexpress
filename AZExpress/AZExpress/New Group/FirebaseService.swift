//
//  FirebaseService.swift
//  AZExpress
//
//  Created by TaNhi on 6/4/20.
//  Copyright © 2020 Duc Chinh. All rights reserved.
//

import Foundation
import FirebaseCore
import FirebaseDatabase

class FirebaseService {
    static let shared = FirebaseService()
    
    func database() -> Database {
        return Database.database()
    }
    
    func databaseRef() -> DatabaseReference {
        return database().reference()
    }
}
