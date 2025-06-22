//
//  APIPlayer.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 23.05.2025..
//

import Foundation

public struct APIPlayer: Codable {

    public let id: Int
    public let name: String?
    public let shortName: String?
    public let position: String?
    public let jerseyNumber: String?
    public let country: APICountry?
    public let imageUrl: String?
    public let isForeign: Bool?
}
