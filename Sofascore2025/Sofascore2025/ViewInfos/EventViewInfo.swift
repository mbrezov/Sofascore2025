//
//  EventViewInfo.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 02.04.2025..
//

import Foundation
import SofaAcademic

public enum EventStatusStateInfo {

    case notStarted, inProgress, halftime, finished

    init(for eventStatus: EventStatus) {
        switch eventStatus {
        case .notStarted:
            self = .notStarted
        case .inProgress:
            self = .inProgress
        case .halftime:
            self = .halftime
        case .finished:
            self = .finished
        }
    }
}

public enum EventStatusStyleInfo {

    case live, primary, secondary
}

public struct EventStatusInfo {

    let description: String
    let startTimestamp: String
    let style: EventStatusStyleInfo
}

public struct EventTeamInfo {

    let logoURL: URL?
    let name: String
    let score: Int?
    let style: EventStatusStyleInfo
    let scoreStyle: EventStatusStyleInfo
}

public struct EventInfo {

    let id: Int
    let homeTeam: TeamInfo
    let awayTeam: TeamInfo
    let league: LeagueInfo?
    let status: EventStatusStateInfo
    let startTimestamp: Int
    let homeScore: Int?
    let awayScore: Int?

    init(event: Event) {
        self.id = event.id
        self.homeTeam = TeamInfo(for: event.homeTeam)
        self.awayTeam = TeamInfo(for: event.awayTeam)
        self.league = LeagueInfo(for: event.league)
        self.status = EventStatusStateInfo(for: event.status)
        self.startTimestamp = event.startTimestamp
        self.homeScore = event.homeScore
        self.awayScore = event.awayScore
    }
}
