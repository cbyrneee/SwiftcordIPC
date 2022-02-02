//
//  EventData.swift
//  
//
//  Created by Conor Byrne on 30/01/2022.
//

import Foundation

public struct ReadyData : Codable {
    public struct User : Codable {
        public let id, username, discriminator, avatar: String
        public let bot: Bool
        public let flags, premiumType: Int

        enum CodingKeys: String, CodingKey {
            case id, username, discriminator, avatar, bot, flags
            case premiumType = "premium_type"
        }
    }
    
    public struct Config : Codable {
        public let cdnHost, apiEndpoint, environment: String

        enum CodingKeys: String, CodingKey {
            case cdnHost = "cdn_host"
            case apiEndpoint = "api_endpoint"
            case environment
        }
    }
    
    public let user: User
    public let config: Config
    public let v: Int
}
