//
//  APIParameters.swift
//  COMBINE-MVVM-CA-Example
//
//  Created by KAZ MAC 5 on 10/1/24.
//

import Foundation

protocol DictionaryConvertor: Codable {}

//Mark: APIParameters for using in URLrequests
/// Structs that containing all parameters that needed for passing data as body or query string to urlrequest
/// it is cnforming to DictionaryConvertor

struct PostAPIParameters {
    struct PostCommentParams: Encodable {
        var postId: Int
    }
    struct AddPostParam: Encodable {
        var newPost: PostModel
    }
}
