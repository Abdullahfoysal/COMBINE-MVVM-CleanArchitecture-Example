//
//  PostRepositoryImp.swift
//  COMBINE-MVVM-CA-Example
//
//  Created by KAZ MAC 5 on 11/1/24.
//

import Foundation
import Combine

class PostRepositoryImp: PostRepositoryProtocol {
    let postRemoteApi: PostRemoteApiProtocol = PostRemoteApiImp()
    
    func getPostList<R>(_ request: R) -> AnyPublisher<R.ReturnType, NetworkRequestError> where R : Request {
        return postRemoteApi.getPostListRemote()
    }
    
    func getPostCommentList<R>(_ request: R) -> AnyPublisher<R.ReturnType, NetworkRequestError> where R : Request {
        
    }
    
    func addNewPost<R>(_ request: R) -> AnyPublisher<R.ReturnType, NetworkRequestError> where R : Request {
        
    }
    
   
    
   
    
}