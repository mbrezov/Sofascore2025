//
//  DBLeague.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 25.04.2025..
//

import GRDB

public struct DBLeague: Codable, FetchableRecord, PersistableRecord {

    public let id: Int
    public let name: String
    public let countryId: Int
    public let countryName: String
    public let logoUrl: String?
}
