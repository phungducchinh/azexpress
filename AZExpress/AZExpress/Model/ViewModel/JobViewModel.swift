//
//  JobViewModel.swift
//  AZExpress
//
//  Created by Phung Duc Chinh on 6/9/20.
//  Copyright © 2020 Duc Chinh. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

struct JobViewModel{
    var jobList = JobListModel()
    var jobDetail      = JobDetailModel()
    var jobID = ""
    let headers: HTTPHeaders = [
               .accept("application/json")
           ]
    
    
    mutating func addJobListData(data: JobListModel){
        self.jobList = data
    }
    
    mutating func addJpbDetailData(data: JobDetailModel){
        self.jobDetail = data
    }
    
    mutating func updateJobID(data: String){
        self.jobID = data
    }

    func getAllJobListData(onCompletion: @escaping (_ response: JobListModel?)->(), onError:  @escaping (_ errorResponse: ErrorResponse) -> ()) {
        
//        BaseService.callApi(api: .getListJob, onCompletion: {data, status in
//            if status{
//                print(data)
//                do {
//                    let decoder = JSONDecoder()
//                    let response = try decoder.decode(JobListModel.self, from: data)
//                    onCompletion(response)
//                } catch {
//                    let response = ErrorResponse(messages:  "Parse data fail!", code: "424")
//                    onError(response)
//                }
//            }else{
//                print(data)
//                do {
//                    let decoder = JSONDecoder()
//                    let response = try decoder.decode(ErrorResponse.self, from: data)
//                    onError(response)
//                } catch {
//                    let response = ErrorResponse(messages:  "Parse data fail!", code: "424")
//                    onError(response)
//                }
//            }
//        })
        
        let api = API.getListJob
        AF.request(api.baseURL, headers: headers).responseJSON { response in
            print(response)
            guard let data = response.data else{
                let response = ErrorResponse(messages:  "Parse data fail!", code: "424")
                onError(response)
                return
            }
            
            if response.response?.statusCode == 200{
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(JobListModel.self, from: data)
                    onCompletion(response)
                } catch {
                    let response = ErrorResponse(messages:  "Parse data fail!", code: "424")
                    onError(response)
                }
            }else{
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(ErrorResponse.self, from: data)
                    onError(response)
                } catch {
                    let response = ErrorResponse(messages:  "Parse data fail!", code: "424")
                    onError(response)
                }
            }
        }
        
    }
    
    func getJobDetail(onCompletion: @escaping (_ response: JobDetailModel?)->(), onError:  @escaping (_ errorResponse: ErrorResponse) -> ()) {
        let api = API.jobDetail(jobId: self.jobID)
        AF.request(api.baseURL, headers: headers).responseJSON { response in
            print(response)
            guard let data = response.data else{
                let response = ErrorResponse(messages:  "Parse data fail!", code: "424")
                onError(response)
                return
            }
            
            if response.response?.statusCode == 200{
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(JobDetailModel.self, from: data)
                    onCompletion(response)
                } catch {
                    let response = ErrorResponse(messages:  "Parse data fail!", code: "424")
                    onError(response)
                }
            }else{
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(ErrorResponse.self, from: data)
                    onError(response)
                } catch {
                    let response = ErrorResponse(messages:  "Parse data fail!", code: "424")
                    onError(response)
                }
            }
        }
    }
    
}

