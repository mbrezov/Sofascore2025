//
//  APILeague.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 09.04.2025..
//

import Foundation

public struct APILeague: Codable {

    public let id: Int
    public let name: String
    public let country: APICountry?
    public let logoUrl: String?
    public let seasonId: Int?
}
