//
//  FramePacketReader.swift
//  
//
//  Created by Conor Byrne on 29/01/2022.
//

import Foundation
import NIO

class FramePacketReader : PacketReader {
    var opcode: UInt8 = 0x01

    func parse(_ json: String) throws -> Packet {
        let object = try JSONSerialization.jsonObject(with:json.data(using: .utf8)!, options:[]) as! [String:Any]

        guard let command = object["cmd"] as? String else { throw DecodeError.inadequateData }
        guard let data = object["data"] as? [String:Any] else { throw DecodeError.inadequateData }
    
        return FramePacket(command: command, data: data, event: object["evt"] as? String? ?? nil)
    }
}
