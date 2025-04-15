//
//  EventTeamInfoMapper.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 11.04.2025..
//

import Foundation

enum EventTeamInfoMapper {

    static func makeTeamInfo(team: Team, score: Int?, opponentScore: Int?, eventStatus: EventStatus) -> EventTeamInfo {
        EventTeamInfo(
            logoURL: team.logoUrl?.url,
            name: team.name,
            score: score,
            color: EventStatusColorMapper.statusColor(for: score, comparedTo: opponentScore, status: eventStatus),
            scoreColor: EventStatusColorMapper.statusColor(for: score, comparedTo: opponentScore, status: eventStatus, isScore: true)
        )
    }
}
