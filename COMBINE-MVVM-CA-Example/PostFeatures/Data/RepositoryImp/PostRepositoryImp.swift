//
//  PostRepositoryImp.swift
//  COMBINE-MVVM-CA-Example
//
//  Created by KAZ MAC 5 on 11/1/24.
//

import Foundation
import Combine

class PostRepositoryImp: PostRepositoryProtocol {
    let postRemoteApi: PostRemoteApiProtocol
    
    init(postRemoteApi: PostRemoteApiProtocol) {
        self.postRemoteApi = postRemoteApi
    }
    
    func getPostList<R>(_ request: R) -> AnyPublisher<R.ReturnType, NetworkRequestError> where R : Request {
        return postRemoteApi.getPostListRemote(request)
    }
    
    func getPostCommentList<R>(_ request: R) -> AnyPublisher<R.ReturnType, NetworkRequestError> where R : Request {
        return postRemoteApi.getCommentListRemote(request)
    }
    
    func addNewPost<R>(_ request: R) -> AnyPublisher<R.ReturnType, NetworkRequestError> where R : Request {
        return postRemoteApi.addNewPostRemote(request)
    }
    
   
    
   
    
}
