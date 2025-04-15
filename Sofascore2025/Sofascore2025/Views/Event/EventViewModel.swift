//
//  EventViewModel.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 11.03.2025..
//

import Foundation

enum EventStatusColor {

    case live, primary, secondary
}

enum EventStatus {

    case notStarted, inProgress, halftime, finished
}

struct EventTeamInfo {

    let logoURL: URL?
    let name: String
    let score: Int?
    let color: EventStatusColor
    let scoreColor: EventStatusColor
}

struct EventStatusInfo {

    let status: EventStatus
    let description: String
    let descriptionShort: String
    let startTimeText: String
    let color: EventStatusColor
}

class EventViewModel {

    private let event: Event

    let id: Int
    let homeTeamInfo: EventTeamInfo
    let awayTeamInfo: EventTeamInfo
    let statusInfo: EventStatusInfo
    let leagueId: Int?
    let leagueName: String?
    let logoURL: URL?

    var rawEvent: Event {
        return event
    }

    init(event: Event) {
        self.event = event

        self.id = event.id
        self.homeTeamInfo = EventTeamInfoMapper.makeTeamInfo(team: event.homeTeam, score: event.homeScore, opponentScore: event.awayScore, eventStatus: EventStatusApiNameMapper.from(apiName: event.status))
        self.awayTeamInfo = EventTeamInfoMapper.makeTeamInfo(team: event.awayTeam, score: event.awayScore, opponentScore: event.homeScore, eventStatus: EventStatusApiNameMapper.from(apiName: event.status))
        self.statusInfo = EventStatusInfoMapper.makeStatusInfo(from: event)
        self.leagueId = event.league?.id
        self.leagueName = event.league?.name
        self.logoURL = event.league?.logoUrl?.url
    }
}
