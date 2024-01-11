//
//  PostEntity.swift
//  COMBINE-MVVM-CA-Example
//
//  Created by KAZ MAC 5 on 11/1/24.
//

import Foundation

struct PostEntity: Codable,Identifiable {
    let id: Int
    let title: String
    let body: String
}
