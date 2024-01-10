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
    var cancelable: Set<AnyCancellable> = []
    
    
    
    //GET Method
    func getPosts() {
        APIClient.dispatch(APIRouter.GetPosts())
            .sink { _ in }
            receiveValue: { [weak self] posts in
                self?.posts = posts
            }.store(in: &cancelable)
    }
}
