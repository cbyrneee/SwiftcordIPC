//
//  SetActivityPacket.swift
//
//
//  Created by Conor Byrne on 29/01/2022.
//

import Foundation
import NIO

public struct SetActivityPacket : Packet {
    public var opcode = 0x01
    public var presence: PresenceData? = nil
    
    public func encode() throws -> [AnyHashable:Any] {
        var args: [AnyHashable:Any] = [
            "pid": getpid(),
        ]
        
        if let presence = presence {
            args["activity"] = presence.dictionary
        } else {
            args["activity"] = nil
        }
        
        return [
            "cmd": "SET_ACTIVITY",
            "args": args,
            "nonce": "0"
        ]
    }
}
