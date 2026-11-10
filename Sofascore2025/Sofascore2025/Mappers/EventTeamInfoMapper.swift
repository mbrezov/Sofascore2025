//
//  EventTeamInfoMapper.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 11.04.2025..
//

import Foundation

enum EventTeamInfoMapper {

    static func makeTeamInfo(
        team: Team,
        score: Int?,
        opponentScore: Int?,
        eventStatus: EventStatus
    ) -> EventTeamInfo {
        EventTeamInfo(
            id: team.id,
            logoURL: team.logoUrl?.url,
            name: team.name,
            countryName: team.country.name,
            score: score,
            color: EventStatusColorMapper.statusColor(for: score, comparedTo: opponentScore, status: eventStatus),
            scoreColor: EventStatusColorMapper.statusColor(
                for: score,
                comparedTo: opponentScore,
                status: eventStatus,
                isScore: true
            )
        )
    }

    static func makeTeamInfo(eventTeamInfo: EventTeamInfo) -> Team {
        Team(
            id: eventTeamInfo.id,
            name: eventTeamInfo.name,
            logoUrl: eventTeamInfo.logoURL?.description,
            country: Country(name: eventTeamInfo.countryName)
        )
    }
}
