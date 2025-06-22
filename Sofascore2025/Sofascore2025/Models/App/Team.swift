//
//  Team.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 09.04.2025..
//

import Foundation

public struct Team: Codable {

    public let id: Int
    public let name: String
    public let logoUrl: String?
    public let country: Country
}

public struct TeamInfo {

    public let team: Team
    public let manager: TeamManager?
    public let venue: TeamVenue?
}

public struct TeamManager {

    public let id: Int
    public let name: String
    public let country: Country?
    public let imageUrl: String
}

public struct TeamVenueCity {

    public let name: String
}

public struct TeamVenue {

    public let name: String
    public let capacity: Int?
    public let city: TeamVenueCity
}
