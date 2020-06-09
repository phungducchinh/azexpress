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
    case getListJob
    case jobDetail(jobId: String)
    case putImage(jobId: String)
}

extension API: TargetType {
    
    var environmentBaseUrl: String {
        switch NetworkManager.environment {
        case .staging:
            return "https://catalog.azexpress.com.vn/v1/"
        case .qa:
            return "https://catalog.azexpress.com.vn/v1/"
        case .production:
            return "https://catalog.azexpress.com.vn/v1/"
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
        switch self {
        case .getListJob:
            return "tasks"
        case .jobDetail(let jobId), .putImage(let jobId):
            return "tasks/\(jobId)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getListJob, .jobDetail(_):
            return .get
        case .putImage(_):
            return .put
        }
    }
    
    var task: Parameters? {
        return [:   ]
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
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
