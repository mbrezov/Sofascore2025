//
//  LeagueViewModel.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 11.03.2025..
//

import Foundation
import SofaAcademic

class LeagueViewModel: LeagueViewModelProtocol {

    private let league: League

    var name: String { league.name }
    var logoURL: URL? { league.logoUrl?.url }
    var country: Country? { league.country }

    init(league: League) {
        self.league = league
    }
}
