//
//  LeagueViewModel.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 11.03.2025..
//

import Foundation

class LeagueViewModel: LeagueViewModelProtocol {

    private let league: LeagueInfo

    var name: String { league.name }
    var logoURL: URL? { league.logoURL }
    var countryName: String? { league.countryName }

    init(league: LeagueInfo) {
        self.league = league
    }
}
