//
//  APIClient.swift
//  COMBINE-MVVM-CA-Example
//
//  Created by KAZ MAC 5 on 10/1/24.
//

/*
 This class based on this github project
 https://danielbernal.co/writing-a-networking-library-with-combine-codable-and-swift-5/
 Created by: Daniel Bernal
 It changed to be more robust and useful.
 APIRouter and APIParametes class aded
 It also Log all networks request and errors in console
 */

/*
 This class based on this github project
 https://github.com/sajjadsarkoobi/CombineNetworking---SwiftUI/
 Created by: Daniel Bernal
 It changed to be more robust and useful.
 APIRouter and APIParametes class aded
 It also Log all networks request and errors in console
 */

import Foundation
import Combine

//The Request Methods
enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

enum NetworkRequestError: LocalizedError, Equatable {
    case invalidRequest
    case badRequest
    case unauthorized
    case forbidden
    case notFound
    case error4xx(_ code: Int)
    case serverError
    case error5xx(_ code: Int)
    case decodingError(_ description: String)
    case urlSessionFailed(_ error: URLError)
    case timeOut
    case unknownError
}

//Extending Encodable to Serialize a Type into Dictionary
extension Encodable {
    var asDictionary: [String: Any] {
        guard let data = try? JSONEncoder().encode(self) else {return [:]}
        
        guard let dictionary = try? JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as? [String: Any] else {
            return [:]
        }
        return dictionary
    }
}

//Request Protocol
protocol Request {
    var path: String { get }
    var method: HTTPMethod { get }
    var contentType: String { get }
    var body: [String: Any]? { get }
    var queryParams: [String: Any]? { get }
    var headers: [String: String]? { get }
    associatedtype ReturnType: Codable
}

//Default and Helper Methods
extension Request {
    //Default
    var method: HTTPMethod { return .get}
    var contentType: String { return "application/json" }
    var queryParams: [String: Any]? { return nil }
    var body: [String: Any]? { return nil }
    var headers: [String: String]? { return nil }
    
    
    ///Serializes an HTTP dictionary to a JSON data Object
    /// - Parameter params: HTTP Parameters dictionary
    /// - Returns: Encoded Json
    private func requestBodyFrom(params: [String: Any]?) -> Data? {
        guard let params = params else { return nil }
        guard let httpBody = try? JSONSerialization.data(withJSONObject: params, options: []) else {
            return nil
        }
        return httpBody
    }
    
    func addQueryItems(queryParams: [String: Any]?) -> [URLQueryItem]? {
        guard let queryParams = queryParams else {
            return nil
        }
        return queryParams.map({URLQueryItem(name: $0.key, value: "\($0.value)")})
    }
    
    /// Transforms an Request into a standard URL request
    ///  - Parameter baseURL: API Base URL to be used
    ///  - Returns: A ready to use URLRequest
    func asURLRequest(baseURL: String) -> URLRequest? {
        guard var urlComponents = URLComponents(string: baseURL) else { return nil }
        urlComponents.path = "\(urlComponents.path)\(path)"
        urlComponents.queryItems = addQueryItems(queryParams: queryParams)
        guard let finalURL = urlComponents.url else { return nil }
        var request = URLRequest(url: finalURL)
        request.httpMethod = method.rawValue
        request.httpBody = requestBodyFrom(params: body)
        request.allHTTPHeaderFields = headers
        
        /// Set your COmmon Headers here
        /// Like: api secret key for authorization header
        /// Or set your content type
        /// request.setValue("Your API Token Key",forHTTPHeaderField: HTTPHeaderField.authorization.rawValue)
        request.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        
        return request
    }
}

struct NetworkDispather {
    let urlSession: URLSession!
    
    public init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    
    /// Dispatches an URLRequest and returns a publisher
    /// - Parameter request: URLRequest
    /// - Returns: A publisher with the provided decoded data or an error
    func dispatch<ReturnType: Codable>(request: URLRequest) -> AnyPublisher<ReturnType,NetworkRequestError> {
        return urlSession
            .dataTaskPublisher(for: request)
            .subscribe(on: DispatchQueue.global(qos: .default))
            //Map on Request response
            .tryMap({data, response in
                
                //if the response is invalid, throw an error
                guard let response = response as? HTTPURLResponse else {
                    throw httpError(0)
                }
                
                //Log Request result
                Log.info("[\(response.statusCode)] '\(request.url!)'")
                // Log received data
                   if let receivedDataString = String(data: data, encoding: .utf8) {
                       Log.info("Received data: \(receivedDataString)")
                   } else {
                       Log.warning("Unable to convert received data to string")
                   }
                
                if !(200...299).contains(response.statusCode) {
                    throw httpError(response.statusCode)
                }
                //Return Response data
               
                return data
                
            })
            .receive(on: DispatchQueue.main)
            .decode(type: ReturnType.self, decoder: JSONDecoder())
            .mapError { error in
                Log.error("\(error)")
                return handleError(error)
            }
            .eraseToAnyPublisher()
    }
    
    /// Parse a HTTP StatusCode and returns a proper error
    /// - Parameter statusCode: HTTP status code\
    /// - Returns: Mapped Error
    private func httpError(_ statusCode: Int) -> NetworkRequestError {
        switch statusCode {
            case 400: return .badRequest
            case 401: return .unauthorized
            case 403: return .forbidden
            case 404: return .forbidden
            case 402, 405...499: return .error4xx(statusCode)
            case 501...599: return .error5xx(statusCode)
            default: return .unknownError
        }
    }
    
    ///Parse URLSession Publisher errors and return proper ones
    /// - Parameter error: URLSession publisher error
    /// - Returns: Readable NetworkRequestError
    private func handleError(_ error: Error) -> NetworkRequestError {
        switch error {
        case is Swift.DecodingError:
            return .decodingError(error.localizedDescription)
        case let urlError as URLError:
            return .urlSessionFailed(urlError)
        case let error as NetworkRequestError:
            return error
        default:
            return .unknownError
        }
    }
}

struct APIClient {
   private static var networkDispatcher: NetworkDispather = NetworkDispather()
    
    /// Dispatches a Request and returns a publisher
    /// - Parameter request: Request to Dispatch
    /// - Returns: A publisher containing decoded data or an error
    static func dispatch<R: Request>(_ request: R) -> AnyPublisher<R.ReturnType, NetworkRequestError> {
        guard let urlRequest = request.asURLRequest(baseURL: APIConstansts.baseUrl) else {
            return Fail(outputType: R.ReturnType.self, failure: NetworkRequestError.badRequest).eraseToAnyPublisher()
        }
        typealias RequestPublisher = AnyPublisher<R.ReturnType,NetworkRequestError>
        let requestPublisher: RequestPublisher = networkDispatcher.dispatch(request: urlRequest)
        return requestPublisher.eraseToAnyPublisher()
    }
}
