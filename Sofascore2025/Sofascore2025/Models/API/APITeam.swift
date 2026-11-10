//
//  APITeam.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 09.04.2025..
//

import Foundation

public struct APITeam: Codable {

    public let id: Int
    public let name: String
    public let logoUrl: String
    public let country: APICountry?
}

public struct APITeamInfo: Codable {

    public let team: APITeam
    public let manager: APITeamManager?
    public let venue: APITeamVenue?
}

public struct APITeamManager: Codable {

    public let id: Int
    public let name: String
    public let country: APICountry?
    public let imageUrl: String
}

public struct APITeamVenueCity: Codable {

    public let name: String?
}

public struct APITeamVenue: Codable {

    public let name: String
    public let capacity: Int?
    public let city: APITeamVenueCity
}
