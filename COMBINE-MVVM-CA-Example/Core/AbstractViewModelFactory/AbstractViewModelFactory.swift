//
//  AbstractViewModelFactory.swift
//  COMBINE-MVVM-CA-Example
//
//  Created by KAZ MAC 5 on 11/1/24.
//

import Foundation

protocol AbstractViewModelFactory: AnyObject {
    func makePostViewModel() -> PostViewModel
}

class ViewModelFactory: AbstractViewModelFactory {
    func makePostViewModel() -> PostViewModel {
        
        let networkClient: APIClient = .shared
        let remoteApi = PostRemoteApiImp(apiClient: networkClient)
        let repository = PostRepositoryImp(postRemoteApi: remoteApi)
        let getPostListUsecase = GetPostListUsecase(postRepository: repository)
        let getCommentListUsecase = GetCommentListUsecase(postRepository: repository)
        let addNewPostUsecase = AddnewPostUsecase(postRepository: repository)
        
        return PostViewModel(getPostListUsecase: getPostListUsecase,getCommentListUsecase: getCommentListUsecase,addNewPostUsecase: addNewPostUsecase)
    }
}
