//
//  PostViewModel.swift
//  COMBINE-MVVM-CA-Example
//
//  Created by KAZ MAC 5 on 10/1/24.
//

import Foundation
import Combine

class PostViewModel: ObservableObject {
    @Published var posts: [PostModel] = []
    @Published var comments: [Comment] = []
    var cancelable: Set<AnyCancellable> = []
    
    
    
    //GET Method
    func getPosts() {
        APIClient.dispatch(APIRouter.GetPosts())
            .sink { _ in }
            receiveValue: { [weak self] posts in
                self?.posts = posts
            }.store(in: &cancelable)
    }
    
    func getPostComments(postId: Int) {
        APIClient.dispatch(APIRouter.GetPostComments(queryParams: APIParameters.PostCommentParams(postId: postId)))
            .sink { _ in
                
            } receiveValue: {[weak self] comments in
                self?.comments  = comments
            }.store(in: &cancelable)
    }
    
    func postNewPost() {
        let postModel = PostModel(userId: 1, id: 1, title: "foysal title", body: "foysal body")
        APIClient.dispatch(APIRouter.PostNewPost(body: postModel))
            .sink { _ in
                
            } receiveValue: { response in
                    print(response)
            }.store(in: &cancelable)

    }
}
