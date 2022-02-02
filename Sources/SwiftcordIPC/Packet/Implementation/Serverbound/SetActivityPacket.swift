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
        let pid = getpid()
        return [
            "cmd": "SET_ACTIVITY",
            "args": [
                "pid": pid,
                "activity": presence?.dictionary ?? [:]
            ],
            "nonce": "nonce"
        ]
    }
}
