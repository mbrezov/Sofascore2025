//
//  StandingsModelMapper.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 13.06.2025..
//

import Foundation

enum StandingsModelMapper {

    static func makeStandings(from apiStandings: APIStandings) -> Standings {
        let team = Team(
            id: apiStandings.team.id,
            name: apiStandings.team.name,
            logoUrl: apiStandings.team.logoUrl,
            country: Country(name: apiStandings.team.country?.name)
        )

        return Standings(
            team: team,
            position: apiStandings.position,
            matches: apiStandings.matches,
            wins: apiStandings.wins,
            losses: apiStandings.losses,
            draws: apiStandings.draws,
            points: apiStandings.points,
            precentage: apiStandings.precentage,
            scoreFor: apiStandings.scoreFor,
            scoreAgainst: apiStandings.scoreAgainst,
            scoreFormatted: apiStandings.scoreFormatted
        )
    }
}
