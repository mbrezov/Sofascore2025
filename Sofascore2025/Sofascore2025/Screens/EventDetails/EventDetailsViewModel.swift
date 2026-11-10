//
//  EventDetailsViewModel.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 09.04.2025..
//

import Foundation

class EventDetailsViewModel {

    private let event: Event
    private let sportType: SportType?

    let eventId: Int
    let leagueLogoURL: URL?
    let homeTeamInfo: EventTeamInfo
    let awayTeamInfo: EventTeamInfo
    let dateText: String
    let startTimeText: String
    let statusInfo: EventStatusInfo
    let isStarted: Bool
    let leagueDescription: String

    init(event: Event, sportType: SportType?) {
        self.event = event
        self.eventId = event.id
        self.leagueLogoURL = event.league?.logoUrl?.url
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
        self.dateText = DateFormatterService.fullDateFormatted(event.startTimestamp)
        self.startTimeText = DateFormatterService.timeFormatted(event.startTimestamp)
        self.statusInfo = EventStatusInfoMapper.makeStatusInfo(from: event)
        self.isStarted = !(statusInfo.status == .notStarted)
        self.leagueDescription = [
            sportType?.name,
            event.league?.country.name,
            event.league?.name,
            event.round.map { String.roundText($0) }
        ]
        .compactMap { $0 }
        .joined(separator: ", ")
        self.sportType = sportType
    }

    func makeIncidentsViewModel(for eventId: Int) -> IncidentsViewModel? {
        let incidentsViewModel = IncidentsViewModel(
            eventId: eventId, sportType: sportType
        )
        return incidentsViewModel
    }
}
