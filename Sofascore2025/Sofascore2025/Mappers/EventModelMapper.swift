//
//  EventModelMapper.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 27.04.2025..
//

import Foundation

enum EventModelMapper {

    static func makeDBEvent(from event: Event, sportType: SportType) -> DBEvent {
        let league = event.league.map {
            DBLeague(
                id: $0.id,
                name: $0.name,
                countryName: $0.country.name,
                logoUrl: $0.logoUrl,
                seasonId: $0.seasonId
            )
        }

        return DBEvent(
            id: event.id,
            sportType: APIClientMapper.sportAPIName(from: sportType),
            homeTeamId: event.homeTeam.id,
            homeTeamName: event.homeTeam.name,
            homeTeamLogoUrl: event.homeTeam.logoUrl,
            homeTeamCountryName: event.homeTeam.country.name,
            awayTeamId: event.awayTeam.id,
            awayTeamName: event.awayTeam.name,
            awayTeamLogoUrl: event.awayTeam.logoUrl,
            awayTeamCountryName: event.awayTeam.country.name,
            startTimestamp: event.startTimestamp,
            status: event.status,
            leagueId: league?.id,
            leagueName: league?.name ?? .unknownCountry,
            leagueCountryName: league?.countryName,
            leagueLogoUrl: league?.logoUrl,
            leagueSeasonId: league?.seasonId,
            homeScore: event.homeScore,
            awayScore: event.awayScore,
            round: event.round,
            incidents: event.incidents?.map {
                DBIncident(
                    type: $0.type,
                    minute: $0.minute,
                    isHomeTeam: $0.isHomeTeam,
                    extraMinute: $0.extraMinute,
                    player: $0.player,
                    scoreDiff: $0.scoreDiff,
                    score: $0.score,
                    description: $0.description
                )
            }
        )
    }

    static func makeEvent(from dbEvent: DBEvent) -> Event {
        let league: League? = dbEvent.leagueId.map {
            League(
                id: $0,
                name: dbEvent.leagueName,
                country: Country(name: dbEvent.leagueCountryName),
                logoUrl: dbEvent.leagueLogoUrl,
                seasonId: dbEvent.leagueSeasonId
            )
        }

        return Event(
            id: dbEvent.id,
            homeTeam: Team(
                id: dbEvent.homeTeamId,
                name: dbEvent.homeTeamName,
                logoUrl: dbEvent.homeTeamLogoUrl,
                country: Country(name: dbEvent.homeTeamCountryName)
            ),
            awayTeam: Team(
                id: dbEvent.awayTeamId,
                name: dbEvent.awayTeamName,
                logoUrl: dbEvent.awayTeamLogoUrl,
                country: Country(name: dbEvent.awayTeamCountryName)
            ),
            startTimestamp: dbEvent.startTimestamp,
            status: dbEvent.status,
            league: league,
            homeScore: dbEvent.homeScore,
            awayScore: dbEvent.awayScore,
            round: dbEvent.round,
            incidents: dbEvent.incidents?.map {
                Incident(
                    type: $0.type,
                    minute: $0.minute,
                    isHomeTeam: $0.isHomeTeam,
                    extraMinute: $0.extraMinute,
                    player: $0.player,
                    scoreDiff: $0.scoreDiff,
                    score: $0.score,
                    description: $0.description
                )
            }
        )
    }

    static func makeEvent(from apiEvent: APIEvent) -> Event {
        let league: League? = apiEvent.league.map {
            League(
                id: $0.id,
                name: $0.name,
                country: Country(name: $0.country?.name),
                logoUrl: $0.logoUrl,
                seasonId: $0.seasonId
            )
        }

        return Event(
            id: apiEvent.id,
            homeTeam: Team(
                id: apiEvent.homeTeam.id,
                name: apiEvent.homeTeam.name,
                logoUrl: apiEvent.homeTeam.logoUrl,
                country: Country(name: apiEvent.homeTeam.country?.name)
            ),
            awayTeam: Team(
                id: apiEvent.awayTeam.id,
                name: apiEvent.awayTeam.name,
                logoUrl: apiEvent.awayTeam.logoUrl,
                country: Country(name: apiEvent.awayTeam.country?.name)
            ),
            startTimestamp: apiEvent.startTimestamp,
            status: apiEvent.status,
            league: league,
            homeScore: apiEvent.homeScore,
            awayScore: apiEvent.awayScore,
            round: apiEvent.round,
            incidents: apiEvent.incidents?.map {
                Incident(
                    type: $0.type,
                    minute: $0.minute,
                    isHomeTeam: $0.isHomeTeam,
                    extraMinute: $0.extraMinute,
                    player: $0.player,
                    scoreDiff: $0.scoreDiff,
                    score: $0.score,
                    description: $0.description
                )
            }
        )
    }
}
