//
//  PostListView.swift
//  COMBINE-MVVM-CA-Example
//
//  Created by KAZ MAC 5 on 10/1/24.
//

import SwiftUI

struct PostListView: View {
    @ObservedObject var viewModel: PostViewModel = PostViewModel()
    var body: some View {
        List(viewModel.posts) { post in
            VStack(alignment: .leading) {
                Text(post.title)
                    .font(.title3)
                Text(post.body)
                    .font(.body)
            }
            
        }
        .onAppear {
            viewModel.getPosts()
        }
    }
}

struct PostListView_Previews: PreviewProvider {
    static var previews: some View {
        PostListView()
    }
}
