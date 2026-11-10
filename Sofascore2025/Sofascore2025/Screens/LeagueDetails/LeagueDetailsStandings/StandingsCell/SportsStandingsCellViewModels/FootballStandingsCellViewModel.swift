//
//  FootballStandingsCellViewModel.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 19.06.2025..
//

import Foundation

class FootballStandingsCellViewModel: SportsCellViewModelProtocol {

    let teamId: Int
    let positionText: String
    let teamName: String
    let stats: [StatItem]
    let statisItemsSpacing: CGFloat = 8

    init (standings: Standings) {
        self.teamId = standings.team.id
        self.teamName = standings.team.name
        self.positionText = standings.position.description

        let goals = "\(standings.scoreFor ?? 0):\(standings.scoreAgainst ?? 0)"
        self.stats = [
            StatItem(label: "P", value: standings.matches.description, labelWidth: 24),
            StatItem(label: "W", value: standings.wins.description, labelWidth: 24),
            StatItem(label: "D", value: standings.draws.description, labelWidth: 24),
            StatItem(label: "L", value: standings.losses.description, labelWidth: 24),
            StatItem(label: "Goals", value: goals, labelWidth: 40),
            StatItem(label: "PTS", value: standings.points?.description ?? "0", labelWidth: 28)
        ]
    }
}
