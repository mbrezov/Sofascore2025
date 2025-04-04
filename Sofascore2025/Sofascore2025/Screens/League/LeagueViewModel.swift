//
//  LeagueViewModel.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 11.03.2025..
//

import Foundation
import SofaAcademic

class LeagueViewModel {

    private let league: League

    var id: Int { league.id }
    var name: String { league.name }
    var logoURL: URL? { league.logoUrl?.url }
    var countryName: String? { league.country?.name }

    init(league: League) {
        self.league = league
    }
}
