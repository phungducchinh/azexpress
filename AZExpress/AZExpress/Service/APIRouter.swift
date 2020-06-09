//
//  APIRouter.swift
//  AZExpress
//
//  Created by Phung Duc Chinh on 6/9/20.
//  Copyright © 2020 Duc Chinh. All rights reserved.
//

import Foundation
import Alamofire

enum API {
    //Session
    
}

extension API: TargetType {
    
    var environmentBaseUrl: String {
        switch NetworkManager.environment {
        case .staging:
            return "https://ssl.at-s.com/TestApp/2022/"
        case .qa:
            return "http://demo.and-s.net/shizuoka/1.0/"
        case .production:
            return "http://demo.and-s.net/shizuoka/1.0/"
        }
    }
    
    var baseURL: URL {
        guard let url = URL(string: url) else {
            fatalError("Could not configure API Please change the URL")
        }
        return url
    }
    
    var url: String {
        return environmentBaseUrl + path
    }
    
    var path: String {
        return "/appli/Guidance/LikeCompanyInfoList"
    }
    
    var method: HTTPMethod {
        return .post // - In this version API 1.0 all api will use post method
    }
    
    var task: Parameters? {
        var params: [String: Any] = [:]
        
        return params
        
    }
    
    var headers: [String : String]? {
        let headers: [String: Any] = [:]
        return headers as? [String : String]
    }
    
    var multipartFormData: (MultipartFormData) -> () {
          return {_ in }
    }
    
}


public protocol TargetType {
    
    /// The target's base `URL`.
    var baseURL: URL { get }
    
    /// The path to be appended to `baseURL` to form the full `URL`.
    var path: String { get }
    
    /// The HTTP method used in the request.
    var method: HTTPMethod { get }
    
    /// The type of HTTP task to be performed.
    var task: Parameters? { get }
    
    /// The type of validation to perform on the request. Default is `.none`.
    
    /// The headers to be used in the request.
    var headers: [String: String]? { get }
    
    ///The data to be used in the upload request
    var multipartFormData : (_ multipartFormData: MultipartFormData)->() { get }
        
}

extension MultipartFormData {
    
    func addPhotoToRequestData(photo: UIImage, name: String) {
        
        if let photoDataToRequest = photo.jpegData(compressionQuality: 0) { //transform photo to data
            self.append(photoDataToRequest, withName: name, fileName: "photo.jpg", mimeType: "image/jpg") //append photo data to request data
        }
    }
    
    func addValueMultiFormData<T>(value: T?, key: String) {
        if let value = value {
             append("\(value)".data(using: String.Encoding.utf8)!, withName: key)
        }
    }
    
    func addListValueMultiFormData<T> (value: [T]?, key: String) {
        if let value = value {
            for index in 0 ..< value.count {
                append("\(value[index])".data(using: String.Encoding.utf8)!, withName: "\(key)[\(index)]")
            }
        }
    }
}
