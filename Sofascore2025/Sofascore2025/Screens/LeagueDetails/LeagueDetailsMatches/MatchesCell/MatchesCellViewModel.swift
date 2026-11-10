//
//  MatchesCellViewModel.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 09.06.2025..
//

import Foundation

class MatchesCellViewModel {

    private let event: Event

    let id: Int
    let homeTeamInfo: EventTeamInfo
    let awayTeamInfo: EventTeamInfo
    let statusInfo: EventStatusInfo
    let startTimestampText: String
    let leagueId: Int?
    let leagueName: String?
    let logoURL: URL?

    init(event: Event) {
        self.event = event
        self.id = event.id
        self.homeTeamInfo = EventTeamInfoMapper.makeTeamInfo(
            team: event.homeTeam,
            score: event.homeScore,
            opponentScore: event.awayScore,
            eventStatus: APIClientMapper.eventStatus(from: event.status)
        )
        self.awayTeamInfo = EventTeamInfoMapper.makeTeamInfo(
            team: event.awayTeam,
            score: event.awayScore,
            opponentScore: event.homeScore,
            eventStatus: APIClientMapper.eventStatus(from: event.status)
        )
        self.statusInfo = EventStatusInfoMapper.makeStatusInfo(from: event)
        self.startTimestampText = DateFormatterService.fullDateShortYearFormatted(event.startTimestamp)
        self.leagueId = event.league?.id
        self.leagueName = event.league?.name
        self.logoURL = event.league?.logoUrl?.url
    }
}
