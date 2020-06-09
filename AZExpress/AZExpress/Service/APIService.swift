//
//  APIService.swift
//  AZExpress
//
//  Created by Phung Duc Chinh on 6/9/20.
//  Copyright © 2020 Duc Chinh. All rights reserved.
//

import Foundation
import Alamofire

class APIService {
    static func getData<T: Codable>(_ api: API,_ returnType: T.Type, onCompletion: @escaping (_ result: T?)->(), onError:  @escaping (_ errorResponse: ErrorResponse) -> ()) {
        
        guard Connectivity.isConnectedToInternet() else{
            let response = ErrorResponse(messages: "Không có kết nối internnet", code: "499" )
            onError(response)
            return
        }
        
        AF.request(api.baseURL, method: api.method, parameters: api.task, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            guard let data = response.data else{
                let response = ErrorResponse(messages:  "Somethings went wrong", code: "424")
                onError(response)
                return
            }
            
            if response.response?.statusCode == 204 || response.response?.statusCode == 200 || response.response?.statusCode == 201 {
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(T.self, from: data)
                    onCompletion(response)
                } catch {
                    print("ERROR: \(api.path)")
                    let response = ErrorResponse(messages:  "Parse data fail!", code: "424")
                    onError(response)
                }
                
            } else {
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(ErrorResponse.self, from: data)
                    onError(response)
                } catch {
                    print("ERROR: \(api.path)")
                    let response = ErrorResponse(messages:  "Parse data fail!", code: "424")
                    onError(response)
                }
            }
        }
        
    }
}
