//
//  Post.swift
//  producthunt
//
//  Created by Chung Tran on 08/12/2017.
//  Copyright © 2017 Chung Tran. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Post {
    var name: String?
    var description: String?
    var voteCount: Int?
    var thumbnailImage: String?
    
    init(from json: JSON) {
        self.name = json["name"].string
        self.description = json["tagline"].string
        self.voteCount = json["vote_count"].int
        self.thumbnailImage = json["thumbnail"]["image_url"].string
    }
    
    static func getAll(completion: ((Error?, [Post]?) -> Void)?) {
        let categorySlug = Setting.currentTopicSlug
        HTTP.get(path: "categories/\(categorySlug)/posts") { (error, json) in
            // Catching Error
            guard error == nil else {
                completion?(error, nil)
                return
            }
            
            guard let jsonPosts = json?["posts"].array else {
                completion?(nil, nil)
                return
            }
            var posts = [Post]()
            
            for jsonPost in jsonPosts {
                let post = Post(from: jsonPost)
                posts.append(post)
            }
            completion?(nil, posts)
        }
    }
}
