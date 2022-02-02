//
//  ByteBufferToPacketDecoder.swift
//  
//
//  Created by Conor Byrne on 29/01/2022.
//

import Foundation
import NIO

class ByteBufferToPacketDecoder : ByteToMessageDecoder {
    typealias InboundOut = Packet
    
    private let readers: [PacketReader] = [
        FramePacketReader(),
        ErrorPacketReader()
    ]
    
    func decode(context: ChannelHandlerContext, buffer: inout ByteBuffer) throws -> DecodingState {
        // If the buffer has no bytes to read, we must request that more data be read before decoding
        if (buffer.readableBytes == 0) {
            return .needMoreData
        }
        
        // The opcode and length in the header are Little Endian Unsigned Integers (32bits)
        guard let opcode = buffer.readInteger(endianness: .little, as: UInt32.self) else {
            buffer.moveReaderIndex(to: 0)
            return .needMoreData
        }
        
        // The opcode and length in the header are Little Endian Unsigned Integers (32bits)
        guard let length = buffer.readInteger(endianness: .little, as: UInt32.self) else {
            buffer.moveReaderIndex(to: 0)
            return .needMoreData
        }
        
        // If the specified length is smaller than the amount of bytes we can read, we need more data
        if length < buffer.readableBytes {
            buffer.moveReaderIndex(to: 0)
            return .needMoreData
        }
                
        // The 'data' is encoded as JSON
        guard let data = buffer.readString(length: Int(length)) else {
            buffer.moveReaderIndex(to: 0)
            return .needMoreData
        }
        
        // TODO: Skip over this packet if a reader is not available
        guard let reader = readers.first(where: { $0.opcode == opcode }) else {
            throw DecodeError.readerNotImplemented
        }
        
        let packet = try reader.parse(data)
        context.fireChannelRead(NIOAny(packet))
        
        return .continue
    }
}
