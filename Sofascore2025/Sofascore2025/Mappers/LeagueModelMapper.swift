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
            countryId: apiLeague.country.id,
            countryName: apiLeague.country.name,
            logoUrl: apiLeague.logoUrl
        )
    }

    static func makeDBLeague(from league: League) -> DBLeague {
        DBLeague(
            id: league.id,
            name: league.name,
            countryId: league.country.id,
            countryName: league.country.name,
            logoUrl: league.logoUrl
        )
    }

    static func makeLeague(from dbLeague: DBLeague) -> League {
        League(
            id: dbLeague.id,
            name: dbLeague.name,
            country: Country(
                id: dbLeague.countryId,
                name: dbLeague.countryName
            ),
            logoUrl: dbLeague.logoUrl
        )
    }
}
