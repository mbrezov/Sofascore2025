//
//  LeagueViewInfo.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 02.04.2025..
//

import Foundation
import SofaAcademic

public struct LeagueInfo {

    let id: Int
    let name: String
    let countryName: String?
    let logoURL: URL?

    init?(for league: League?) {
        guard let league = league else { return nil }
        self.init(for: league)
    }

    init(for league: League) {
        self.id = league.id
        self.name = league.name
        self.countryName = league.country?.name
        self.logoURL = league.logoUrl?.url
    }
}
