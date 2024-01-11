//
//  AddNewPostUsecase.swift
//  COMBINE-MVVM-CA-Example
//
//  Created by KAZ MAC 5 on 11/1/24.
//

import Foundation
import Combine

class AddnewPostUsecase: PostUsecaseProtocol {
    var postRepository: PostRepositoryProtocol

    internal init(postRepository: PostRepositoryProtocol) {
        self.postRepository = postRepository
    }
    
    func execute<R>(_ request: R) -> AnyPublisher<R.ReturnType, NetworkRequestError> where R : Request {
        return postRepository.addNewPost(request)
    }
            
    
}
