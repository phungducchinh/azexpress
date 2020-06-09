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
/*
class BaseService {
    
//MARK: -Use API for communication with server
    static func callApi(api: TargetType, onCompletion: @escaping (_ response: Data,_ status: Bool, _ statuscode: Int) -> ()) {
        Alamofire.request(api.baseURL, method: api.method, parameters: api.task, encoding: JSONEncoding.default, headers: api.headers).responseJSON { (response) in

            guard let data = response.data else{
                onCompletion(Data(), false, response.response?.statusCode ?? 599)
                return
            }
                        
            if response.response?.statusCode == 204 || response.response?.statusCode == 200 || response.response?.statusCode == 201 {
                onCompletion(data, true, response.response?.statusCode ?? 200)
                
            } else {
                onCompletion(data, false, response.response?.statusCode ?? 499)
            }
        }
    }
    
//MARK: -Use API for upload file to server
    static func callUploadAPI(api: TargetType, onCompletion: @escaping (_ response: Data,_ status: Bool, _ statuscode: Int) -> ()) {
        
        Alamofire.upload(multipartFormData: api.multipartFormData ,usingThreshold: UInt64.init(), to: api.baseURL, method: api.method, headers: api.headers) { (result) in
            
            switch result {
            case .success(let upload, _, _): //if upload successfully
                
               upload.responseJSON(completionHandler: { response in
                
                    guard let data = response.data else{
                        onCompletion(Data(), false, response.response?.statusCode ?? 599)
                        return
                    }
                    
                    if response.response?.statusCode == 204 || response.response?.statusCode == 200 || response.response?.statusCode == 201 {
                        onCompletion(data, true, response.response?.statusCode ?? 200)
                        
                    } else {
                        onCompletion(data, false, response.response?.statusCode ?? 499)
                    }
               })
                
            case .failure(let error): //if upload not successfully
                print(error)
                onCompletion(Data(), false, 599)
            }
            
        }
    }
    
    static func request(api: TargetType, onCompletion: @escaping (_ response: DictionaryRespone,_ status: Bool, _ statuscode: Int) -> ()) {
        
        Alamofire.request(api.baseURL, method: api.method, parameters: api.task, encoding: JSONEncoding.default, headers: api.headers).responseJSON { (response) in
            
            guard let data = response.result.value else{
                onCompletion([], false, response.response?.statusCode ?? 599)
                return
            }
            
            if response.response?.statusCode == 204 || response.response?.statusCode == 200 || response.response?.statusCode == 201 {
                
                if let dic = data as? DictionaryRespone {
                    onCompletion(dic, true, response.response?.statusCode ?? 200)
                } else {
                    onCompletion([], false, response.response?.statusCode ?? 499)
                }
                                
            } else {
                onCompletion([], false, response.response?.statusCode ?? 499)
            }
        }
    }
    
    static func requestNews(api: TargetType, onCompletion: @escaping (_ response: ModelDictionaryRaw,_ status: Bool, _ statuscode: Int) -> ()) {
        
        Alamofire.request(api.baseURL, method: api.method, parameters: api.task, encoding: JSONEncoding.default, headers: api.headers).responseJSON { (response) in
            
            guard let data = response.result.value else{
                onCompletion([:], false, response.response?.statusCode ?? 599)
                return
            }
            
            if response.response?.statusCode == 204 || response.response?.statusCode == 200 || response.response?.statusCode == 201 {
                
                if let dic = data as? ModelDictionaryRaw {
                    onCompletion(dic, true, response.response?.statusCode ?? 200)
                } else {
                    onCompletion([:], false, response.response?.statusCode ?? 499)
                }
                                
            } else {
                onCompletion([:], false, response.response?.statusCode ?? 499)
            }
        }
    }

}

*/
