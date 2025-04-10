//
//  EventViewModel.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 11.03.2025..
//

import Foundation

enum EventStatusStyle {

    case live, primary, secondary
}

enum EventStatus {

    case notStarted, inProgress, halftime, finished

    init(rawName: String) {
        switch rawName {
        case "NOT_STARTED":
            self = .notStarted
        case "IN_PROGRESS":
            self = .inProgress
        case "HALF_TIME":
            self = .halftime
        case "FINISHED":
            self = .finished
        default:
            self = .notStarted
        }
    }
}

struct EventTeamInfo {

    let logoURL: URL?
    let name: String
    let score: Int?
    let style: EventStatusStyle
    let scoreStyle: EventStatusStyle
}

struct EventStatusInfo {

    let status: EventStatus
    let description: String
    let startTimeText: String
    let style: EventStatusStyle
}

class EventViewModel {

    private let event: Event

    let id: Int
    let homeTeamInfo: EventTeamInfo
    let awayTeamInfo: EventTeamInfo
    let statusInfo: EventStatusInfo
    let startTimestamp: Int
    let leagueId: Int?
    let leagueName: String?
    let leagueCountry: String?
    let logoURL: URL?

    init(event: Event) {
        self.event = event

        self.id = event.id
        self.homeTeamInfo = Self.makeTeamInfo(team: event.homeTeam, score: event.homeScore, opponentScore: event.awayScore, eventStatus: EventStatus(rawName: event.status))
        self.awayTeamInfo = Self.makeTeamInfo(team: event.awayTeam, score: event.awayScore, opponentScore: event.homeScore, eventStatus: EventStatus(rawName: event.status))
        self.statusInfo = Self.makeStatusInfo(from: event)
        self.startTimestamp = event.startTimestamp
        self.leagueId = event.league?.id
        self.leagueName = event.league?.name
        self.leagueCountry = event.league?.country.name
        self.logoURL = event.league?.logoUrl?.url
    }

    private static func makeTeamInfo(team: Team, score: Int?, opponentScore: Int?, eventStatus: EventStatus) -> EventTeamInfo {
        EventTeamInfo(
            logoURL: team.logoUrl?.url,
            name: team.name,
            score: score,
            style: statusStyle(for: score, comparedTo: opponentScore, status: eventStatus),
            scoreStyle: statusStyle(for: score, comparedTo: opponentScore, status: eventStatus, isScore: true)
        )
    }

    private static func makeStatusInfo(from event: Event) -> EventStatusInfo {
        let description: String
        let status = EventStatus(rawName: event.status)

        switch status {
        case .notStarted:
            description = .matchStatusNotStarted

        case .inProgress:
            description = DateFormatterService.timeRemaining(event.startTimestamp)

        case .halftime:
            description = .matchStatusHalftime

        case .finished:
            description = .matchStatusFulltime
        }

        return EventStatusInfo(
            status: EventStatus(rawName: event.status),
            description: description,
            startTimeText: DateFormatterService.timeFormatted(event.startTimestamp),
            style: status == .inProgress ? .live : .secondary
        )
    }

    private static func statusStyle(for score: Int?, comparedTo opponentScore: Int?, status: EventStatus, isScore: Bool = false) -> EventStatusStyle {
        switch status {
        case .inProgress:
            return isScore ? .live : .primary

        case .finished:
            return (score ?? 0) > (opponentScore ?? 0) ? .primary : .secondary

        default:
            return .primary
        }
    }
}
