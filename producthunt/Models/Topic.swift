//
//  Topic.swift
//  producthunt
//
//  Created by Chung Tran on 08/12/2017.
//  Copyright © 2017 Chung Tran. All rights reserved.
//

import Foundation
import SwiftyJSON

class Topic {
    var name: String?
    var slug: String?
    
    // Initialize
    init(from json: JSON) {
        name = json["name"].string
        slug = json["slug"].string
    }
    
    // MARK: Static functions
    static func getAll(completion: ((Error?, [Topic]?) -> Void)?) {
        HTTP.get(path: "topics") { (error, json) in
            // Catching Error
            guard error == nil else {
                completion?(error, nil)
                return
            }
            
            guard let jsonTopics = json?["topics"].array else {
                completion?(nil, nil)
                return
            }
            var topics = [Topic]()
            
            for jsonTopic in jsonTopics {
                let topic = Topic(from: jsonTopic)
                topics.append(topic)
            }
            completion?(nil, topics)
        }
    }
}
