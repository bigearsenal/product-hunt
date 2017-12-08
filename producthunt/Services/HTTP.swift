//
//  HTTP.swift
//  producthunt
//
//  Created by Chung Tran on 08/12/2017.
//  Copyright © 2017 Chung Tran. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class HTTP {
    // Testing token
    private static let token = "591f99547f569b05ba7d8777e2e0824eea16c440292cce1f8dfb3952cc9937ff"
    
    // Default HTTP headers
    private static let headers: HTTPHeaders = [
        "Authorization": "Bearer \(token)",
        "Accept": "application/json"
    ]
    
    // URL prefix
    private static let urlPrefix = "https://api.producthunt.com/v1/"
    
    // Static function
    static func get(path: String, completion: ((Error?, JSON?) -> Void)?) {
        Alamofire.request("\(urlPrefix)\(path)", headers: headers)
            .validate()
            .responseJSON { (response) in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    completion?(nil, json)
                case .failure(let error):
                    print(error)
                    completion?(error, nil)
                }
        }
    }
}
