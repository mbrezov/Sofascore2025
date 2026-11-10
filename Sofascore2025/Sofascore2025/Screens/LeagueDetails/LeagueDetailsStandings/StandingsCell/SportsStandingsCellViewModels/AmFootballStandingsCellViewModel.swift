//
//  AmFootballStandingsCellViewModel.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 19.06.2025..
//

import Foundation

class AmFootballStandingsCellViewModel: SportsCellViewModelProtocol {

    let teamId: Int
    let positionText: String
    let teamName: String
    let stats: [StatItem]
    let statisItemsSpacing: CGFloat = 8

    init (standings: Standings) {
        self.teamId = standings.team.id
        self.teamName = standings.team.name
        self.positionText = standings.position.description

        let wins = standings.wins
        let matches = standings.matches
        let pct = Double(wins) / Double(matches)
        let pctString = String(format: "%.3f", pct)

        self.stats = [
            StatItem(label: "P", value: standings.matches.description, labelWidth: 24),
            StatItem(label: "W", value: standings.wins.description, labelWidth: 24),
            StatItem(label: "D", value: standings.draws.description, labelWidth: 24),
            StatItem(label: "L", value: standings.losses.description, labelWidth: 24),
            StatItem(label: "PCT", value: pctString, labelWidth: 40)
        ]
    }
}
