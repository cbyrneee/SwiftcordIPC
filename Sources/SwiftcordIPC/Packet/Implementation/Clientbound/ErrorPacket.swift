//
//  ErrorPacket.swift
//  
//
//  Created by Conor Byrne on 29/01/2022.
//

import Foundation
import NIO

public struct ErrorPacket : Packet {
    public var opcode: Int = 0x02
    
    public let code: Double
    public let message: String
    
    public func encode() throws -> [AnyHashable:Any] {
        throw EncodeError.notSupported
    }
}
