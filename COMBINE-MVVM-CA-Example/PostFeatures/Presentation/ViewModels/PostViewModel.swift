//
//  PostViewModel.swift
//  COMBINE-MVVM-CA-Example
//
//  Created by KAZ MAC 5 on 10/1/24.
//

import Foundation
import Combine

class PostViewModel: AbstractViewModel {
    @Published var posts: [PostModel] = []
    @Published var comments: [Comment] = []
    var cancelable: Set<AnyCancellable> = []
    let getPostListUsecase: GetPostListUsecase //= GetPostListUsecase(postRepository: PostRepositoryImp())
    let getCommentListUsecase: GetCommentListUsecase
    let addNewPostUsecase: AddnewPostUsecase
    
    init(getPostListUsecase: GetPostListUsecase, getCommentListUsecase: GetCommentListUsecase, addNewPostUsecase: AddnewPostUsecase) {
        self.getPostListUsecase = getPostListUsecase
        self.getCommentListUsecase = getCommentListUsecase
        self.addNewPostUsecase = addNewPostUsecase
    }
    
    //GET Method
    func getPosts() {
        getPostListUsecase.execute(APIRouter.GetPosts())
            .sink { _ in }
            receiveValue: { [weak self] posts in
                self?.posts = posts
            }.store(in: &cancelable)
    }
    //GET with Query
    func getPostComments(postId: Int) {
        getCommentListUsecase.execute(APIRouter.GetPostComments(queryParams: APIParameters.PostCommentParams(postId: postId)))
            .sink { _ in
                
            } receiveValue: {[weak self] comments in
                self?.comments  = comments
            }.store(in: &cancelable)
    }
    
    //POST Method
    func postNewPost() {
        let postModel = PostModel(userId: 1, id: 1, title: "foysal title", body: "foysal body")
        addNewPostUsecase.execute(APIRouter.PostNewPost(body: postModel))
            .sink { _ in
                
            } receiveValue: { response in
                print(response)
                
            }.store(in: &cancelable)

    }
}
