//
//  EventDetailsViewModel.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 09.04.2025..
//

import Foundation

class EventDetailsViewModel {

    private let event: Event

    let country: String?
    let leagueName: String?
    let leagueLogoURL: URL?
    let homeTeamInfo: EventTeamInfo
    let awayTeamInfo: EventTeamInfo
    let dateText: String
    let startTimeText: String
    let statusInfo: EventStatusInfo
    let isNotStarted: Bool
    let roundText: String
    let selectedSportText: String?

    init(event: Event, selectedSport: SportType?) {
        self.event = event

        self.country = event.league?.country.name
        self.leagueName = event.league?.name
        self.leagueLogoURL = event.league?.logoUrl?.url
        self.homeTeamInfo = EventTeamInfoMapper.makeTeamInfo(team: event.homeTeam, score: event.homeScore, opponentScore: event.awayScore, eventStatus: EventStatusApiNameMapper.from(apiName: event.status))
        self.awayTeamInfo = EventTeamInfoMapper.makeTeamInfo(team: event.awayTeam, score: event.awayScore, opponentScore: event.homeScore, eventStatus: EventStatusApiNameMapper.from(apiName: event.status))
        self.dateText = DateFormatterService.fullDateFormatted(event.startTimestamp)
        self.startTimeText = DateFormatterService.timeFormatted(event.startTimestamp)
        self.statusInfo = EventStatusInfoMapper.makeStatusInfo(from: event)
        self.isNotStarted = statusInfo.status == .notStarted
        self.roundText = .roundText(event.id.description)
        self.selectedSportText = selectedSport?.name
    }
}
