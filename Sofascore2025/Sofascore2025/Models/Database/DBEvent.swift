//
//  DBEvent.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 25.04.2025..
//

import GRDB

public struct DBEvent: Codable, FetchableRecord, PersistableRecord {

    public let id: Int
    public let sportType: String
    public let homeTeamId: Int
    public let homeTeamName: String
    public let homeTeamLogoUrl: String?
    public let awayTeamId: Int
    public let awayTeamName: String
    public let awayTeamLogoUrl: String?
    public let startTimestamp: Int
    public let leagueId: Int
    public let leagueName: String
    public let leagueCountryId: Int
    public let leagueCountryName: String
    public let leagueLogoUrl: String
    public let status: String
    public let homeScore: Int?
    public let awayScore: Int?
}
