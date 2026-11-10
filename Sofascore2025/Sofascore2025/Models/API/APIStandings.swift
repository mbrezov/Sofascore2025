//
//  APIStandings.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 23.05.2025..
//

import Foundation

public struct APIStandings: Codable {

    public let team: APITeam
    public let position: Int
    public let matches: Int
    public let wins: Int
    public let losses: Int
    public let draws: Int
    public let points: Int?
    public let precentage: Double?
    public let scoreFor: Int?
    public let scoreAgainst: Int?
    public let scoreFormatted: String?
}
