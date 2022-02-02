//
//  PacketReader.swift
//  
//
//  Created by Conor Byrne on 29/01/2022.
//

import Foundation
import NIO

protocol PacketReader {
    var opcode: UInt8 { get }
    func parse(_ json: String) throws -> Packet
}

