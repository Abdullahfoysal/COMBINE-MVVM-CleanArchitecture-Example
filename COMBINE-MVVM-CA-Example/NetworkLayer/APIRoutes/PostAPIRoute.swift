//
//  APIRouter.swift
//  COMBINE-MVVM-CA-Example
//
//  Created by KAZ MAC 5 on 10/1/24.
//

import Foundation

struct PostAPIRoute {
    //Get Request
    struct GetPosts: Request {
        typealias ReturnType = [PostEntity]
        
        var path: String = "/posts"
        var method: HTTPMethod = .get
    }
    
    struct GetPostComments: Request {
        typealias ReturnType = [Comment]
        
        var path: String = "/comments"
        var queryParams: [String : Any]?
        
        init(queryParams: PostAPIParameters.PostCommentParams) {
            self.queryParams = queryParams.asDictionary
        }
    }
    
    struct PostNewPost: Request {
        typealias ReturnType = PostModel
        var path: String = "/posts"
        var method: HTTPMethod = .post
        var body: [String : Any]?
        
        init(body: PostModel) {
            self.body = body.asDictionary
        }
    }
}
