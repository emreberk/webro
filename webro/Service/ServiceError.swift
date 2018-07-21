//
//  ServiceError.swift
//  webro
//
//  Created by Emre Berk on 21.07.2018.
//  Copyright © 2018 Emre Berk. All rights reserved.
//

import Foundation

enum ServiceError: Error {
    
    case parseFailed
    case requestFailed
    case unknown
    case service(code: Int, message: String)
    
    var message: String {
        
        switch self {
        case .service(_, let message):
            return message
        default:
            return "An error occured."
        }
    }
}
