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
        NavigationView {
            List(viewModel.posts) { post in
                NavigationLink {
                    PostCommentListView()
                } label: {
                    VStack(alignment: .leading) {
                        Text(post.title ?? "n/a")
                            .font(.title3)
                            .foregroundColor(.blue)
                        Text(post.body ?? "n/a")
                            .font(.body)
                    }
                    .padding()
                }

                       // Add padding inside the card's VStack
                
                
                
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
        PostListView()
    }
}
