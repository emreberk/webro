//
//  User.swift
//  webro
//
//  Created by Emre Berk on 21.07.2018.
//  Copyright © 2018 Emre Berk. All rights reserved.
//

import Foundation
import ObjectMapper

class User: Mappable {
    
    var userId: String?
    var email: String?
    var accessToken: String?
    
    static var current: User? {
        didSet {
            UserDefaults.standard.accessToken = current?.accessToken
        }
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        userId <- map["userId"]
        email <- map["email"]
        accessToken <- map["accessToken"]
    }
}
