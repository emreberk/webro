//
//  TasksResponse.swift
//  webro
//
//  Created by Emre Berk on 21.07.2018.
//  Copyright © 2018 Emre Berk. All rights reserved.
//

import Foundation
import ObjectMapper

class TasksResponse: Mappable {
    
    var tasks: [Task]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        tasks <- map["tasks"]
    }
}
