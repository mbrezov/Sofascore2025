//
//  Incident.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 23.05.2025..
//

import Foundation

public struct Incident: Codable {

    public let type: String
    public let minute: Int
    public let isHomeTeam: Bool?
    public let extraMinute: Int?
    public let player: String?
    public let scoreDiff: Int?
    public let score: String?
    public let description: String?
}
