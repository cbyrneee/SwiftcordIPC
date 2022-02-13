//
//  PresenceData.swift
//  
//
//  Created by Conor Byrne on 30/01/2022.
//

import Foundation

public struct PresenceData: Codable {
    public var state: String? = nil
    public var details: String? = nil
    public var timestamps: Timestamps? = nil
    public var assets: Assets? = nil
    public var party: Party? = nil
    public var secrets: Secrets? = nil
    public var instance: Bool? = nil
    public var buttons: [Button]? = nil
    
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
        public let id: String?
        public let size: [Int]?
    }

    public struct Secrets: Codable {
        public let join, spectate, match: String?
    }

    public struct Timestamps: Codable {
        public let start, end: Int?
    }
    
    public struct Button: Codable {
        public let label, url: String?
    }
}
