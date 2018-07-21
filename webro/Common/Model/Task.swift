//
//  Task.swift
//  webro
//
//  Created by Emre Berk on 21.07.2018.
//  Copyright © 2018 Emre Berk. All rights reserved.
//

import ObjectMapper

enum TaskType: String {
    case auto = "A"
    case human = "H"
    case package = "P"
    
    var description: String {
        switch self {
        case .auto:
            return "Vinç"
        case .human:
            return "İnsan"
        case .package:
            return "Paket"
        }
    }
    
    var icon: UIImage {
        switch self {
        case .auto:
            return #imageLiteral(resourceName: "icAuto")
        case .human:
            return #imageLiteral(resourceName: "icHuman")
        case .package:
            return #imageLiteral(resourceName: "icPackage")
        }
    }
}

enum TaskStatus: String {
    case active = "A"
    case passive = "P"
    case completed = "C"
}

class Location: Mappable {
    
    var latitude: Double?
    var longitude: Double?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        latitude <- map["lat"]
        longitude <- map["lon"]
    }
}

class Task: Mappable {
    
    var user: User?
    var type: TaskType?
    var status: TaskStatus?
    var fromLocation: Location?
    var toLocation: Location?
    var address: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        user <- map["user"]
        type <- map["type"]
        status <- map["status"]
        fromLocation <- map["fromlocation"]
        toLocation <- map["toLocation"]
        address <- map["address"]
    }
}
