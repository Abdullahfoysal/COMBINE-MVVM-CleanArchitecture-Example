//
//  Log.swift
//  COMBINE-MVVM-CA-Example
//
//  Created by KAZ MAC 5 on 10/1/24.
//

import Foundation

enum Log {
    enum LogLevel {
        case info
        case warning
        case error
        
        fileprivate var prefix: String {
            switch self {
             case .info:    return "ℹ️ INFO"
             case .warning: return "⚠️ WARN"
             case .error:   return "❌ ALERT"
            }
        }
    }
    
    struct Context {
        let file: String
        let function: String
        let line: Int
        var description: String {
            return "\((file as NSString).lastPathComponent): \(line) \(function)"
        }
        
    }
    
    static func info(_ str: String, shouldLogContext: Bool = true , file: String = #file, function: String = #function, line: Int = #line) {
        let context = Context(file: file, function: function, line: line)
        Log.handleLog(level: .info, str: str.description, shouldLogContext: shouldLogContext, context: context)
    }
    
    static func warning(_ str: String, shouldLogContext: Bool = true, file: String = #file, function: String = #function, line: Int = #line) {
        let context = Context(file: file, function: function, line: line)
        Log.handleLog(level: .warning, str: str.description, shouldLogContext: shouldLogContext, context: context)
    }
    
    static func error(_ str: String, shouldLogContext: Bool = true, file: String = #file, function: String = #function, line: Int = #line) {
        let context = Context(file: file, function: function, line: line)
        Log.handleLog(level: .error, str: str.description, shouldLogContext: shouldLogContext, context: context)
    }
    
    static func networkLog(request: URLRequest, response: HTTPURLResponse,data: Data,shouldLogContext: Bool = true, file: String = #file, function: String = #function, line: Int = #line) {
        let context = Context(file: file, function: function, line: line)
       
        var requestBody = ""
        if let body = String(data: request.httpBody ?? Data(), encoding: .utf8) {
          requestBody = body
       }
        
        Log.handleLog(level: .info, str: "\(request.httpMethod!) '\(request.url!)'\n\(requestBody)", shouldLogContext: shouldLogContext, context: context)
       
        if let receivedDataString = String(data: data, encoding: .utf8) {
            Log.handleLog(level: .info, str: "[\(response.statusCode)]\(receivedDataString)", shouldLogContext: shouldLogContext, context: context)
       } else {
           Log.handleLog(level: .warning, str: "unable to convert data to string", shouldLogContext: shouldLogContext, context: context)
       }
    }
    
    fileprivate static func handleLog(level: LogLevel, str: String, shouldLogContext: Bool, context: Context) {
        let logComponents = ["[\(level.prefix)]",str]
        var fullString = logComponents.joined(separator: " ")
        if shouldLogContext {
            fullString += " ➜ \(context.description)"
        }
        
        #if DEBUG
        print(fullString)
        #endif
    }
    
    
    
}
