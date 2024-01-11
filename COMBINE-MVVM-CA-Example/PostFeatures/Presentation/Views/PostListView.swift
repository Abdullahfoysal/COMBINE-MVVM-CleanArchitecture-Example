//
//  PostListView.swift
//  COMBINE-MVVM-CA-Example
//
//  Created by KAZ MAC 5 on 10/1/24.
//

import SwiftUI

struct PostListView: View {
    @StateObject  var viewModel: PostViewModel
    var body: some View {
        NavigationView {
            List(viewModel.posts) { post in
                NavigationLink {
                    PostCommentListView(viewModel: viewModel, postId: post.id)
                } label: {
                    VStack(alignment: .leading) {
                        Text(post.title)
                            .font(.title3)
                            .foregroundColor(.blue)
                        Text(post.body)
                            .font(.body)
                    }
                    .padding()
                }
                
            }.navigationTitle("Post List View")
                .toolbar {
                    Button("Add") {
                        viewModel.postNewPost()
                    }
                }
        }
      
        .onAppear {
            viewModel.getPosts()
        }
    }
}

struct PostListView_Previews: PreviewProvider {
    static var previews: some View {
        PostListView(viewModel: ViewModelFactory().makePostViewModel())
    }
}
