import Foundation
import NIO

public class SwiftcordIPC : SocketConnectionDelegate {
    private var connection: SocketConnection?
    public var clientId: String
    
    public var onReady: ((ReadyData) -> ())? = nil
    public var onError: ((Error) -> ())? = nil
    public var onDisconnect: (() -> ())? = nil

    public func onSocketReady(data: ReadyData) {
        onReady?(data)
    }
    
    public func onSocketError(error: Error) {
        onError?(error)
    }
    
    public func onSocketDisconnect() {
        onDisconnect?()
    }
    
    public init(id: String) {
        self.clientId = id
    }

    public func connectAndBlock() throws {
        let file = try getIPCFile()
        
        self.connection = try SocketConnection.create(path: file, clientId: clientId)
        self.connection?.delegate = self
        
        try connection?.channel?.closeFuture.wait()
    }
    
    public func disconnect() {
        let _ = connection?.channel?.close()
    }
    
    public func setPresence(_ data: PresenceData) {
        connection?.channel?.writeAndFlush(NIOAny(SetActivityPacket(presence: data)), promise: nil)
    }
    
    public func setPresence(_ build: (inout PresenceData) -> ()) {
        var data = PresenceData()
        build(&data)
        
        setPresence(data)
    }
    
    public func setPresence(
        details: String? = nil,
        state: String? = nil,
        start: Int? = nil,
        end: Int? = nil,
        largeImage: String? = nil,
        largeImageText: String? = nil,
        smallImage: String? = nil,
        smallImageText: String? = nil,
        buttonText: String? = nil,
        buttonUrl: String? = nil
    ) {
        let presence = PresenceData(
            state: state,
            details: details,
            timestamps: start != nil && end != nil ? PresenceData.Timestamps(start: start!, end: end!) : nil,
            assets: PresenceData.Assets(largeImage: largeImage, largeText: largeImageText, smallImage: smallImage, smallText: smallImageText),
            party: nil,
            secrets: nil,
            instance: nil,
            buttons: buttonText != nil && buttonUrl != nil ? [PresenceData.Button(label: buttonText, url: buttonUrl)] : nil
        )
        
        setPresence(presence)
    }
    
    /// Gets the IPC file to connect with the Discord IPC server
    ///
    /// This is a recursive function, if no ``index`` is supplied, it will attempt 0 as the first index.
    /// If $TMPDIR/discord-ipc-0 doesn't exist, it will try ipc-1...ipc-9 until it finds one.
    /// It will only try up to 5 because Discord doesn't open more than 5 sockets at a time. (it usually only has one or two open)
    ///
    /// If a file still isn't found, ``ConnectionError.noIpcFile`` will be thrown.
    public func getIPCFile(index: Int? = nil) throws -> String {
        let base = "\(NSTemporaryDirectory())/discord-ipc-"
        if let index = index {
            // At the moment, Discord only supports up to 9 unix domain sockets, if we've exceeded this count, throw an error
            if index > 9 {
                throw ConnectionError.noIpcFile
            }
            
            // Try the current index, if it fails, increment and go again
            if !FileManager.default.fileExists(atPath: "\(base)\(index)") {
                return try getIPCFile(index: index + 1)
            }
            
            return "\(base)\(index)"
        } else {
            // Try discord-ipc-0 if an index hasn't been specified
            if !FileManager.default.fileExists(atPath: "\(base)0") {
                return try getIPCFile(index: 0)
            }
            
            return "\(base)0"
        }
    }
}
