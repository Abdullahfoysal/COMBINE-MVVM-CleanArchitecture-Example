//
//  APIRouter.swift
//  COMBINE-MVVM-CA-Example
//
//  Created by KAZ MAC 5 on 10/1/24.
//

import Foundation

class APIRouter {
    //Get Request
    struct GetPosts: Request {
        typealias ReturnType = [PostModel]
        
        var path: String = "/posts"
        var method: HTTPMethod = .get
    }
}
