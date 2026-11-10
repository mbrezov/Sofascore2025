//
//  TeamInfoModelMapper.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 20.06.2025..
//

import Foundation

enum TeamInfoModelMapper {

    static func makeTeamInfo(from apiTeamInfo: APITeamInfo) -> TeamInfo? {
        guard let manager = apiTeamInfo.manager else { return nil}
        guard let venue = apiTeamInfo.venue else { return nil}

        return TeamInfo(
            team: Team(
                id: apiTeamInfo.team.id,
                name: apiTeamInfo.team.name,
                logoUrl: apiTeamInfo.team.logoUrl,
                country: Country(name: apiTeamInfo.team.country?.name)),
            manager: TeamManager(
                id: manager.id,
                name: manager.name,
                country: Country(name: manager.country?.name),
                imageUrl: manager.imageUrl),
            venue: TeamVenue(
                name: venue.name,
                capacity: venue.capacity,
                city: TeamVenueCity(name: venue.city.name ?? .unknownCityName)
            )
        )
    }
}
