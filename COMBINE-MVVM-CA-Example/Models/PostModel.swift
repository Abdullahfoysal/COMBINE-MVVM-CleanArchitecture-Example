//
//  PostModel.swift
//  COMBINE-MVVM-CA-Example
//
//  Created by KAZ MAC 5 on 10/1/24.
//

import Foundation

// Mark: - Post
struct PostModel: Codable,Identifiable {
    let userId: Int?
    let id: Int?
    let title: String?
    let body: String?
}

// Mark: - Comment
struct Comment: Codable,Identifiable {
    let postId: Int
    let id: Int
    let name: String
    let email: String
    let body: String
}
