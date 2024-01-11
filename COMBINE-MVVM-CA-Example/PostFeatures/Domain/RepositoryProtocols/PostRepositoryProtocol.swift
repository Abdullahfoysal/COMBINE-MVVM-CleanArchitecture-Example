//
//  PostRepositoryProtocol.swift
//  COMBINE-MVVM-CA-Example
//
//  Created by KAZ MAC 5 on 11/1/24.
//

import Foundation
import Combine

protocol PostRepositoryProtocol {
   
    func getPostList<R: Request>(_ request: R) -> AnyPublisher<R.ReturnType, NetworkRequestError>
    func getPostCommentList<R: Request>(_ request: R) -> AnyPublisher<R.ReturnType, NetworkRequestError>
    func addNewPost<R: Request>(_ request: R) -> AnyPublisher<R.ReturnType, NetworkRequestError>
}
