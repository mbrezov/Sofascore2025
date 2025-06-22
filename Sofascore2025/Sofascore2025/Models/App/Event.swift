//
//  Event.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 09.04.2025..
//

import Foundation

public struct Event: Codable {

    public let id: Int
    public let homeTeam: Team
    public let awayTeam: Team
    public let startTimestamp: Int
    public let status: String
    public let league: League?
    public let homeScore: Int?
    public let awayScore: Int?
    public let round: Int?
    public let incidents: [Incident]?
}
