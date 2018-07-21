//
//  Service.swift
//  webro
//
//  Created by Emre Berk on 21.07.2018.
//  Copyright © 2018 Emre Berk. All rights reserved.
//

import Alamofire
import ObjectMapper

// Hero Mode On:
fileprivate enum C {
    static let shouldLogRequests = true
}

class Service {
    
    static var main = Service()
    
    private init() {}
    
    private let baseURL = URL(string: "http://192.168.30.233:8081/api/")!//!webro.herokuapp.com/api/")!
    private let defaultParameters: [String : Any] = [:]
    private let defaultHeaders: [String : String] = [:]
    
    func request<T:Mappable>(_ endpoint: Endpoint,
                             _ completion: @escaping (_ item: T?, _ error: ServiceError?) -> Void) {
        
        var params = endpoint.request.parameters
        
        for (key,value) in defaultParameters {
            params[key] = value
        }
        
        let endpointURL = baseURL.appendingPathComponent(endpoint.request.path)
        
        let encoding: ParameterEncoding = endpoint.request.method == .get ? URLEncoding.default : JSONEncoding.default
        let request = Alamofire.request(endpointURL,
                                        method: endpoint.request.method,
                                        parameters: params,
                                        encoding: encoding,
                                        headers: nil)
        
        if C.shouldLogRequests {
            print("REQUEST: ",
                  "\n\tmethod:",request.request?.httpMethod,
                  "\n\turl:",request.request?.url?.absoluteString)
        }
        
        request.responseJSON { response in
            
            let (data, error) = self.parse(response: response)
            
            if C.shouldLogRequests {
                print("RESPONSE:",
                      "\n\turl:",request.request?.url?.absoluteString,
                      "\n\t", "response json:", response.result.value as? JSON ?? "",
                      "\n\t", "error:", error?.localizedDescription ?? "")
            }
            
            if let data = data {
                if let object = Mapper<T>().map(JSONObject: data) {
                    completion(object, nil)
                } else {
                    completion(nil, ServiceError.parseFailed)
                }
            } else {
                completion(nil, error)
            }
        }
    }
    
    private func parse(response: DataResponse<Any>) -> (data: JSON?, error: ServiceError?) {
        if !response.result.isSuccess || response.response?.statusCode != 200 {
            return (data: nil, error: ServiceError.requestFailed)
        }
        
        guard let json = response.result.value as? JSON else {
            return (data: nil, error: ServiceError.parseFailed)
        }
        
        if let errorMessage = json["msg"] as? String {
            return (data: nil, error: ServiceError.service(code: 1, message: errorMessage))
        }
        
        return (data: json, error: nil)
    }
}
// Hero Mode Off:
