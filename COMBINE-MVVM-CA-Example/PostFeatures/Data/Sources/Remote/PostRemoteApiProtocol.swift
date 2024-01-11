//
//  PostRemoteApiProtocol.swift
//  COMBINE-MVVM-CA-Example
//
//  Created by KAZ MAC 5 on 11/1/24.
//

import Foundation
import Combine

protocol PostRemoteApiProtocol {
    
    func getPostListRemote<R: Request>(_ request: R) -> AnyPublisher<R.ReturnType, NetworkRequestError>
    func getCommentListRemote<R: Request>(_ request: R) -> AnyPublisher<R.ReturnType, NetworkRequestError>
    func addNewPostRemote<R: Request>(_ request: R) -> AnyPublisher<R.ReturnType, NetworkRequestError>
}
