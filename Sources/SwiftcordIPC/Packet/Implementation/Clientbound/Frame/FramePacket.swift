//
//  FramePacket.swift
//  
//
//  Created by Conor Byrne on 29/01/2022.
//

import Foundation
import NIO

public struct FramePacket : Packet {
    public var opcode = 0x01
    
    var command: String
    var data: [String: Any]
    var event: String?

    public func encode() throws -> [AnyHashable:Any] {
        throw EncodeError.notSupported
    }
}
