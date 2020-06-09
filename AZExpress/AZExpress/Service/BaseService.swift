//
//  BaseService.swift
//  AZExpress
//
//  Created by Phung Duc Chinh on 6/9/20.
//  Copyright © 2020 Duc Chinh. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class BaseService {
 
    static func callApi(api: API, onCompletion: @escaping (_ response: Data,_ status: Bool) -> ()) {
        AF.request(api.baseURL, method: api.method, parameters: api.task, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            guard let data = response.data else{
                onCompletion(Data(), false)
                return
            }
            
            if response.response?.statusCode == 204 || response.response?.statusCode == 200 || response.response?.statusCode == 201 {
                onCompletion(data, true)
                
            } else {
                onCompletion(data, false)
            }
        }
    }
    
    
}
