//
//  LeagueHeaderViewModel.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 11.03.2025..
//

import Foundation
import SofaAcademic

class LeagueHeaderViewModel {

    private let league: League

    let id: Int
    let name: String
    let logoURL: URL?
    let countryName: String?

    init(league: League) {
        self.league = league

        self.id = league.id
        self.name = league.name
        self.logoURL = league.logoUrl?.url
        self.countryName = league.country?.name
    }
}
