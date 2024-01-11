//
//  PostUsecaseProtocol.swift
//  COMBINE-MVVM-CA-Example
//
//  Created by KAZ MAC 5 on 11/1/24.
//

import Foundation
import Combine

protocol PostUsecaseProtocol {
    var postRepository: PostRepositoryProtocol { get }
    func execute<R: Request>(_ request: R) -> AnyPublisher<R.ReturnType,NetworkRequestError>
}
