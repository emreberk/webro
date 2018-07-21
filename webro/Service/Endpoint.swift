//
//  Endpoint.swift
//  webro
//
//  Created by Emre Berk on 21.07.2018.
//  Copyright © 2018 Emre Berk. All rights reserved.
//

import Foundation

enum Endpoint {
    
    case login(email: String, password: String)
    
    var request: Request {
        
        switch self {
            
        case let .login(email, password):
            let parameters = ["email": email,
                              "password": password]
            return Request(path: "login", method: .post, parameters: parameters)
        }
    }
}
