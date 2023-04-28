//
//  NSDictionary+Extensions.swift
//  Foap
//
//  Created by Tolu Oluwagbemi on 28/04/2023.
//

import UIKit
import Foundation

extension NSDictionary {
    // Method to retreive Dictionary as String
    func string(_ key: String) -> String? {
        if let value = self[key] as? String {
            return value
        }
        return nil
    }
    
    // Method to retreive Dictionary as Int
    func int(_ key: String) -> Int? {
        if let value = self[key] as? Int {
            return value
        }
        return nil
    }
    // Method to retreive Dictionary as a ResponseProtocol type
    // Type T is specified in usage
    func type<T: ResponseProtocol>(_ key: String) -> T? {
        if let value = self[key] as? NSDictionary {
            return T.init(value)
        }
        return nil
    }
    
    // Method to retreive Dictionary as a ResponseProtocol list
    // Type T is specified in usage
    func list<T: ResponseProtocol>(_ key: String) -> [T]? {
        if let values = self[key] as? [NSDictionary] {
            return values.map { T.init($0) }
        }
        return nil
    }
    
    // Method to retreive Dictionary as a String list
    func list(_ key: String) -> [String]? {
        if let stringValues = self[key] as? [String] {
            return stringValues.map { $0 }
        }
        return nil
    }
}
