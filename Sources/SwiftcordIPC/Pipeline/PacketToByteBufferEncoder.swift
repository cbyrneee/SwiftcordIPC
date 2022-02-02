//
//  PacketToByteBufferEncoder.swift
//  
//
//  Created by Conor Byrne on 29/01/2022.
//

import Foundation
import NIO

public class PacketToByteBufferEncoder : MessageToByteEncoder {
    public typealias OutboundIn = Packet
    
    public func encode(data: Packet, out: inout ByteBuffer) throws {
        // Fuck you Michael Bublé
        let json = try data.encode().toJson().data(using: .utf8)!

        out.writeInteger(UInt32(data.opcode), endianness: .little, as: UInt32.self)
        out.writeInteger(UInt32(json.count), endianness: .little, as: UInt32.self)
        out.writeBytes(json)
    }
}
