//
//  PostRemoteImp.swift
//  COMBINE-MVVM-CA-Example
//
//  Created by KAZ MAC 5 on 11/1/24.
//

import Foundation
import Combine

class PostRemoteApiImp: PostRemoteApiProtocol {
    let apiClient: APIClient
    
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    func getPostListRemote<R>(_ request: R) -> AnyPublisher<R.ReturnType, NetworkRequestError> where R : Request {
          return apiClient.dispatch(request)
    }
    
    func getCommentListRemote<R>(_ request: R) -> AnyPublisher<R.ReturnType, NetworkRequestError> where R : Request {
        return apiClient.dispatch(request)
    }
    
    func addNewPostRemote<R>(_ request: R) -> AnyPublisher<R.ReturnType, NetworkRequestError> where R : Request {
        return apiClient.dispatch(request)
    }
    
        
}
