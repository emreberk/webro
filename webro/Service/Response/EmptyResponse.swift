//
//  EmptyResponse.swift
//  webro
//
//  Created by Emre Berk on 21.07.2018.
//  Copyright © 2018 Emre Berk. All rights reserved.
//

import Foundation
import ObjectMapper

class EmptyResponse: Mappable {
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {

    }
}
