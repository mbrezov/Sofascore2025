//
//  TeamDetailsViewModel.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 22.05.2025..
//

import Foundation

class TeamDetailsViewModel {

    private let teamId: Int

    let name: String
    let logoURL: URL?
    let countryName: String

    init(team: Team) {
        self.teamId = team.id
        self.name = team.name
        self.countryName = team.country.name ?? .unknownCountry
        self.logoURL = team.logoUrl?.url
    }

    func makeInfoViewModel() -> InfoViewModel {
        InfoViewModel(teamId: teamId)
    }

    func makeSquadViewModel() -> SquadViewModel {
        SquadViewModel(teamId: teamId)
    }
}
