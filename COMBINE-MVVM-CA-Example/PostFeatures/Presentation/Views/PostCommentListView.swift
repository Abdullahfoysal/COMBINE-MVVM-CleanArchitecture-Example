//
//  PostCommentListView.swift
//  COMBINE-MVVM-CA-Example
//
//  Created by KAZ MAC 5 on 10/1/24.
//

import SwiftUI

struct PostCommentListView: View {
    @ObservedObject var viewModel: PostViewModel = PostViewModel()
    var body: some View {
    
            List(viewModel.comments) { comment in
               
                    VStack(alignment: .leading) {
                        Text(comment.email)
                            .font(.title3)
                            .foregroundColor(.blue)
                        Text(comment.body)
                            .font(.body)
                    }
                    .padding()
                

                       // Add padding inside the card's VStack
                
                
                
            }.navigationTitle("Post Comments")
     
        .onAppear {
            viewModel.getPostComments(postId: 1)
        }
    }
}

struct PostCommentListView_Previews: PreviewProvider {
    static var previews: some View {
        PostCommentListView(viewModel: PostViewModel())
    }
}
