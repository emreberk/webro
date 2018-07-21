//
//  Request.swift
//  webro
//
//  Created by Emre Berk on 21.07.2018.
//  Copyright © 2018 Emre Berk. All rights reserved.
//

import Foundation
import Alamofire

struct Request {
    
    var path: String
    var method: Alamofire.HTTPMethod
    var parameters: [String : Any]
}
