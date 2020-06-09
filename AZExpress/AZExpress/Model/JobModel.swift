//
//  JobModel.swift
//  AZExpress
//
//  Created by Phung Duc Chinh on 6/9/20.
//  Copyright © 2020 Duc Chinh. All rights reserved.
//

import Foundation
import UIKit

struct JobDetailModel: Codable {
    var task_code              : String?
    var house_number           : String?
    var street_name            : String?
    var ward                   : String?
    var district               : String?
    var province               : String?
    var address                : String?
    var status                 : String?
}

struct JobListModel: Codable {
    
}

