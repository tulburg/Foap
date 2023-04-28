//
//  Data+Extensions.swift
//  Foap
//
//  Created by Tolu Oluwagbemi on 28/04/2023.
//

import Foundation

extension Data {
    // Serialize data to json object
    func json() -> Dictionary<String, Any> {
        do {
            return try JSONSerialization.jsonObject(with: self, options: []) as! Dictionary<String, Any>
        } catch {
            print(error.localizedDescription)
            return [:]
        }
    }
}
