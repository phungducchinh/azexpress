//
//  ErrorResponse.swift
//  AZExpress
//
//  Created by Phung Duc Chinh on 6/9/20.
//  Copyright © 2020 Duc Chinh. All rights reserved.
//

import Foundation
import UIKit

enum ErrorType {
    case network
    case normal
    case signin
}

struct ErrorResponse: Codable{
    var status:     String?
    var messages:   String?
    var code:       String?
    var result: Int?
}
