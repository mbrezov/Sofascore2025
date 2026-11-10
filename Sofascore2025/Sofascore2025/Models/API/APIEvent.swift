//
//  APIEvent.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 09.04.2025..
//

import Foundation

public struct APIEvent: Codable {

    public let id: Int
    public let homeTeam: APITeam
    public let awayTeam: APITeam
    public let startTimestamp: Int
    public let status: String
    public let league: APILeague?
    public let homeScore: Int?
    public let awayScore: Int?
    public let round: Int?
    public let incidents: [APIIncident]?
}
