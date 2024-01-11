//
//  Configuration.swift
//  COMBINE-MVVM-CA-Example
//
//  Created by KAZ MAC 5 on 11/1/24.
//

import Foundation

enum EnvConfig: String {
    enum ConfigError: Error {
        case misingKey
    }
    
    case BASE_URL
  
    static func value(_ key: EnvConfig) throws -> String {
        guard let value = Bundle.main.object(forInfoDictionaryKey: key.rawValue) as? String else {
            throw ConfigError.misingKey
        }
        return value
    }
}
