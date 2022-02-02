//
//  DecodeError.swift
//  
//
//  Created by Conor Byrne on 29/01/2022.
//

import Foundation

enum DecodeError : Error {
    case badIpcFrame
    case readerNotImplemented
    case inadequateData
}
