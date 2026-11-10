//
//  LeagueDetailsViewModel.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 22.05.2025..
//

import Foundation

class LeagueDetailsViewModel {

    private let league: League

    let id: Int
    let name: String
    let logoURL: URL?
    let countryName: String?
    let sportType: SportType?

    init(league: League, sportType: SportType?) {
        self.league = league
        self.id = league.id
        self.name = league.name
        self.logoURL = league.logoUrl?.url
        self.countryName = league.country.name
        self.sportType = sportType
    }

    func makeMatchesViewModel() -> MatchesViewModel? {
        let matchesViewModel = MatchesViewModel(
            league: league,
            sportType: sportType
        )
        return matchesViewModel
    }

    func makeStandingsViewModel() -> StandingsViewModel? {
        let standingsViewModel = StandingsViewModel(
            leagueId: league.id,
            sportType: sportType
        )
        return standingsViewModel
    }
}
