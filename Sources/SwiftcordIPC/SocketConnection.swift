//
//  SocketConnection.swift
//  
//
//  Created by Conor Byrne on 29/01/2022.
//

import Foundation
import NIO

public class SocketConnection : ChannelInboundHandler {
    public typealias InboundIn = Packet
    
    private var clientId: String

    public var channel: Channel? = nil
    public var delegate: SocketConnectionDelegate? = nil

    public init(_ clientId: String) {
        self.clientId = clientId
    }
    
    static func create(path: String, clientId: String) throws -> SocketConnection {
        let instance = SocketConnection(clientId)
        let group = MultiThreadedEventLoopGroup(numberOfThreads: 1)
        let bootstrap = ClientBootstrap(group: group)
            .channelOption(ChannelOptions.socketOption(.so_reuseaddr), value: 1)
            .channelInitializer { channel in
                channel.pipeline.addHandlers(
                    ByteToMessageHandler(ByteBufferToPacketDecoder()),
                    MessageToByteHandler(PacketToByteBufferEncoder()),
                    instance
                )
            }
        
        instance.channel = try bootstrap.connect(unixDomainSocketPath: path).wait()
        return instance
    }
    
    public func channelActive(context: ChannelHandlerContext) {
        context.channel.writeAndFlush(NIOAny(HandshakePacket(clientId: clientId)), promise: nil)
    }
    
    public func channelInactive(context: ChannelHandlerContext) {
        delegate?.onSocketDisconnect()
    }
    
    public func channelRead(context: ChannelHandlerContext, data: NIOAny) {
        do {
            let inbound = self.unwrapInboundIn(data)
            
            switch inbound {
            case let packet as ErrorPacket:
                print("Received error (\(packet.code)): \(packet.message))")
            case let packet as FramePacket:
                guard let event = packet.event else { return }
                switch event {
                case "READY":
                    delegate?.onSocketReady(data: try packet.data.decode(ReadyData.self))
                case "ERROR":
                    print(packet.data)
                default:
                    print("Unimplemented event: \(event)")
                }
            default:
                print("Packet handler not implemented: \(inbound)")
            }
        } catch (let error) {
            errorCaught(context: context, error: error)
            context.close(promise: nil)
        }
    }

    public func errorCaught(context: ChannelHandlerContext, error: Error) {
        delegate?.onSocketError(error: error)
    }
}
