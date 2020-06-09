//
//  NetworkManager.swift
//  AZExpress
//
//  Created by Phung Duc Chinh on 6/9/20.
//  Copyright © 2020 Duc Chinh. All rights reserved.
//

import Foundation
import Alamofire

enum APIEnvironment {
    case staging
    case qa
    case production
}

struct NetworkManager {
    static let environment: APIEnvironment = .staging
}

class Connectivity {
    class func isConnectedToInternet() ->Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
