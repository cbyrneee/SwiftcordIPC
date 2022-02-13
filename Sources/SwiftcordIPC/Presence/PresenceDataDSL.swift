//
//  PresenceDataDSL.swift
//  
//
//  Created by Conor Byrne on 02/02/2022.
//

import Foundation

public func buildPresence(_ build: (inout PresenceData) -> ()) -> PresenceData {
    var data = PresenceData()
    build(&data)
    
    return data
}

public func button(label: String, url: String) -> PresenceData.Button {
    return PresenceData.Button(label: label, url: url)
}

public func timestamp(start: Int, end: Int) -> PresenceData.Timestamps {
    return PresenceData.Timestamps(start: start, end: end)
}

public func secrets(join: String? = nil, spectate: String? = nil, match: String? = nil) -> PresenceData.Secrets {
    return PresenceData.Secrets(join: join, spectate: spectate, match: match)
}

public func assets(
    largeImage: String? = nil,
    largeImageText: String? = nil,
    smallImage: String? = nil,
    smallImageText: String? = nil
) -> PresenceData.Assets {
    return PresenceData.Assets(largeImage: largeImage, largeText: largeImageText, smallImage: smallImage, smallText: smallImageText)
}

