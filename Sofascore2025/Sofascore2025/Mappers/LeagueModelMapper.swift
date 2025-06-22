//
//  LeagueModelMapper.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 27.04.2025..
//

import Foundation

enum LeagueModelMapper {

    static func makeDBLeague(from apiLeague: APILeague) -> DBLeague {
        DBLeague(
            id: apiLeague.id,
            name: apiLeague.name,
            countryName: apiLeague.country?.name,
            logoUrl: apiLeague.logoUrl,
            seasonId: apiLeague.seasonId
        )
    }

    static func makeDBLeague(from league: League) -> DBLeague {
        DBLeague(
            id: league.id,
            name: league.name,
            countryName: league.country.name,
            logoUrl: league.logoUrl,
            seasonId: league.seasonId
        )
    }

    static func makeLeague(from dbLeague: DBLeague) -> League {
        League(
            id: dbLeague.id,
            name: dbLeague.name,
            country: Country(
                name: dbLeague.countryName
            ),
            logoUrl: dbLeague.logoUrl,
            seasonId: dbLeague.seasonId
        )
    }

    static func makeLeague(from apiLeague: APILeague) -> League {
        League(
            id: apiLeague.id,
            name: apiLeague.name,
            country: Country(
                name: apiLeague.country?.name
            ),
            logoUrl: apiLeague.logoUrl,
            seasonId: apiLeague.seasonId
        )
    }
}
