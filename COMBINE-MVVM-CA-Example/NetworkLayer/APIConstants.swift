//
//  APIConstants.swift
//  COMBINE-MVVM-CA-Example
//
//  Created by KAZ MAC 5 on 10/1/24.
//

import Foundation

//final class APIConstansts {
//    static var baseUrl: String = "https://jsonplaceholder.typicode.com"
//}

enum HTTPHeaderField: String {
    case authentication = "Authentication"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
    case authorization = "Authorization"
    case acceptLanguage = "Accept-Language"
    case userAgent = "User-Agent"
}

enum ContentType: String {
    case json = "application/json"
    case jsonUTF8 = "application/json; charset=UTF-8"
    case xwwwformurlencoded = "application/x-www-form-urlencoded"
}
