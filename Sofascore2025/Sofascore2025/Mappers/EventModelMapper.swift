//
//  EventModelMapper.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 27.04.2025..
//

import Foundation

enum EventModelMapper {

    static func makeDBEvent(from apiEvent: APIEvent, sportType: SportType) -> DBEvent {
        DBEvent(
            id: apiEvent.id,
            sportType: APIClientMapper.sportAPIName(from: sportType),
            homeTeamId: apiEvent.homeTeam.id,
            homeTeamName: apiEvent.homeTeam.name,
            homeTeamLogoUrl: apiEvent.homeTeam.logoUrl,
            awayTeamId: apiEvent.awayTeam.id,
            awayTeamName: apiEvent.awayTeam.name,
            awayTeamLogoUrl: apiEvent.awayTeam.logoUrl,
            startTimestamp: apiEvent.startTimestamp,
            leagueId: apiEvent.league.id,
            leagueName: apiEvent.league.name,
            leagueCountryId: apiEvent.league.country.id,
            leagueCountryName: apiEvent.league.country.name,
            leagueLogoUrl: apiEvent.league.logoUrl,
            status: apiEvent.status,
            homeScore: apiEvent.homeScore,
            awayScore: apiEvent.awayScore
        )
    }

    static func makeEvent(from dbEvent: DBEvent) -> Event {
        Event(
            id: dbEvent.id,
            homeTeam: Team(
                id: dbEvent.homeTeamId,
                name: dbEvent.homeTeamName,
                logoUrl: dbEvent.homeTeamLogoUrl
            ),
            awayTeam: Team(
                id: dbEvent.awayTeamId,
                name: dbEvent.awayTeamName,
                logoUrl: dbEvent.awayTeamLogoUrl
            ),
            startTimestamp: dbEvent.startTimestamp,
            league: League(
                id: dbEvent.leagueId,
                name: dbEvent.leagueName,
                country: Country(
                    id: dbEvent.leagueCountryId,
                    name: dbEvent.leagueCountryName
                ),
                logoUrl: dbEvent.leagueLogoUrl
            ),
            status: dbEvent.status,
            homeScore: dbEvent.homeScore,
            awayScore: dbEvent.awayScore
        )
    }
}
