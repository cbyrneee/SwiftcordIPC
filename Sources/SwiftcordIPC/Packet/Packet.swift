//
//  Packet.swift
//  
//
//  Created by Conor Byrne on 29/01/2022.
//

import Foundation
import NIO

public protocol Packet {
    var opcode: Int { get }
    
    /// Writes a packet's data to a buffer
    ///
    /// - Parameters:
    ///   - buffer: the buffer to write to
    func encode() throws -> [AnyHashable:Any]
    
    /// Converts this packet into a human readable string, formatted as JSON
    ///
    /// Example of what your response should look like
    /// ```json
    /// (0x00): {"message": "hello world!"}
    /// ```
    func toString() -> String
}

extension Packet {
    public func toString() -> String {
        return ["opcode": opcode].description
    }
}
