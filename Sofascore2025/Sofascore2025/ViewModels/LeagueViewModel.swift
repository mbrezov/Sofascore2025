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

    var leagueName: String { league.name }
    var leagueLogoUrl: URL? { StringFormatterService.stringToURL(league.logoUrl) }
    var country: Country? { league.country }

    init(league: League) {
        self.league = league
    }
}
