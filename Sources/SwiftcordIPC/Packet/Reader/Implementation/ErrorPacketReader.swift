//
//  ErrorPacketReader.swift
//  
//
//  Created by Conor Byrne on 29/01/2022.
//

import Foundation
import NIO

class ErrorPacketReader : PacketReader {
    var opcode: UInt8 = 0x02
    
    struct Data : Codable {
        var code: Double
        var message: String
    }

    func parse(_ json: String) throws -> Packet {
        let decoder = JSONDecoder()
        let data = try decoder.decode(Data.self, from: json.data(using: .utf8)!)
        
        return ErrorPacket(code: data.code, message: data.message)
    }
}
