//
//  File.swift
//  
//
//  Created by Conor Byrne on 30/01/2022.
//

import Foundation

public protocol SocketConnectionDelegate {
    func onSocketReady(data: ReadyData)
    func onSocketError(error: Error)

    func onSocketDisconnect()
}
