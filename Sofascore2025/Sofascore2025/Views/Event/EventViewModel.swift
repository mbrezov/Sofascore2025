//
//  EventViewModel.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 11.03.2025..
//

import Foundation
import SofaAcademic

enum EventStatusStyle {

    case live, primary, secondary
}

struct EventTeamInfo {

    let logoURL: URL?
    let name: String
    let score: Int?
    let style: EventStatusStyle
    let scoreStyle: EventStatusStyle
}

struct EventStatusInfo {

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
    let leagueId: Int?
    let leagueName: String?

    init(event: Event) {
        self.event = event

        self.id = event.id
        self.homeTeamInfo = Self.makeTeamInfo(team: event.homeTeam, score: event.homeScore, opponentScore: event.awayScore, eventStatus: event.status)
        self.awayTeamInfo = Self.makeTeamInfo(team: event.awayTeam, score: event.awayScore, opponentScore: event.homeScore, eventStatus: event.status)
        self.statusInfo = Self.makeStatusInfo(from: event)
        self.leagueId = event.league?.id
        self.leagueName = event.league?.name
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

        switch event.status {
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
            description: description,
            startTimeText: DateFormatterService.timeFormatted(event.startTimestamp),
            style: event.status == .inProgress ? .live : .secondary
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
