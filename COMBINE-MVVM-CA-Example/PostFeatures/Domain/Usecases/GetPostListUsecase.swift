//
//  GetPostListUsecase.swift
//  COMBINE-MVVM-CA-Example
//
//  Created by KAZ MAC 5 on 11/1/24.
//

import Foundation
import Combine

class GetPostListUsecase: PostUsecaseProtocol {
    var postRepository: PostRepositoryProtocol
    init(postRepository: PostRepositoryProtocol) {
        self.postRepository = postRepository
    }
    
    func execute<R>(_ request: R) -> AnyPublisher<R.ReturnType, NetworkRequestError> where R : Request {
        return postRepository.getPostList(request)
    }
}
