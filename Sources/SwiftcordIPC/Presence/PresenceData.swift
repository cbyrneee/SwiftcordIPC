//
//  PresenceData.swift
//  
//
//  Created by Conor Byrne on 30/01/2022.
//

import Foundation

public struct PresenceData: Codable {
    public let state, details: String?
    public let timestamps: Timestamps?
    public let assets: Assets?
    public let party: Party?
    public let secrets: Secrets?
    public let instance: Bool?
    public let buttons: [Button]?
    
    public struct Assets: Codable {
        public let largeImage, largeText, smallImage, smallText: String?

        enum CodingKeys: String, CodingKey {
            case largeImage = "large_image"
            case largeText = "large_text"
            case smallImage = "small_image"
            case smallText = "small_text"
        }
    }

    public struct Party: Codable {
        let id: Int?
        let size: [Int]?
    }

    public struct Secrets: Codable {
        let join, spectate, match: String?
    }

    public struct Timestamps: Codable {
        let start, end: Int64?
    }
    
    public struct Button: Codable {
        public let label, url: String?
    }
}
