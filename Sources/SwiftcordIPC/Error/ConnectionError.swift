//
//  ConnectionError.swift
//
//
//  Created by Conor Byrne on 29/01/2022.
//

import Foundation

public enum ConnectionError : Error {
    case noIpcFile
    case noClientId
}
