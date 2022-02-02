//
//  Dictionary+SwiftcordIPC.swift
//  
//
//  Created by Conor Byrne on 30/01/2022.
//

import Foundation

extension Dictionary {
    func toJson() throws -> String {
        let data = try JSONSerialization.data(withJSONObject: self)
        if let string = String(data: data, encoding: .utf8) {
            return string
        }
        
        throw EncodeError.invalidData
    }
    
    func decode<T>(_ type: T.Type) throws -> T where T: Decodable {
        let jsonDecoder = JSONDecoder()
        let jsonData = try JSONSerialization.data(withJSONObject: self, options: [])
        return try jsonDecoder.decode(type, from: jsonData)
    }
}

extension Encodable {
    var dictionary: [String: Any] {
        return (try? JSONSerialization.jsonObject(with: JSONEncoder().encode(self))) as? [String: Any] ?? [:]
    }
}
