//
//  HandshakePacket.swift
//  
//
//  Created by Conor Byrne on 29/01/2022.
//

import Foundation
import NIO

public struct HandshakePacket : Packet {
    public var opcode = 0x00
    
    public var version = 1
    public var clientId: String

    public func encode() throws -> [AnyHashable:Any] {
        return ["v": version, "client_id": clientId]
    }
}
