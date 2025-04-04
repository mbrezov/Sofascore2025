//
//  EventViewModel.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 11.03.2025..
//

import Foundation
import SofaAcademic

enum EventStatusStyleInfo {

    case live, primary, secondary
}

struct EventTeamInfo {

    let logoURL: URL?
    let name: String
    let score: Int?
    let style: EventStatusStyleInfo
    let scoreStyle: EventStatusStyleInfo
}

struct EventStatusInfo {

    let description: String
    let startTimeText: String
    let style: EventStatusStyleInfo
}

class EventViewModel {

    private let event: Event

    var id: Int { event.id }

    var homeTeamInfo: EventTeamInfo {
        EventTeamInfo(
            logoURL: event.homeTeam.logoUrl?.url,
            name: event.homeTeam.name,
            score: event.homeScore,
            style: statusColor(for: event.homeScore,comparedTo: event.awayScore),
            scoreStyle: statusColor(for: event.homeScore, comparedTo: event.awayScore, isScore: true)
        )
    }

    var awayTeamInfo: EventTeamInfo {
        EventTeamInfo(
            logoURL: event.awayTeam.logoUrl?.url,
            name: event.awayTeam.name, score: event.awayScore,
            style: statusColor(for: event.awayScore, comparedTo: event.homeScore),
            scoreStyle: statusColor(for: event.awayScore, comparedTo: event.homeScore, isScore: true)
        )
    }

    var statusInfo: EventStatusInfo {
        EventStatusInfo(
            description: matchStatusDescription,
            startTimeText: DateFormatterService.timeFormatted(event.startTimestamp),
            style: event.status == .inProgress ? .live : .secondary
        )
    }

    var leagueId: Int? { event.league?.id }

    var leagueName: String? { event.league?.name }

    private var matchStatusDescription: String {
        switch event.status {
        case .notStarted:
            return .matchStatusNotStarted

        case .inProgress:
            return DateFormatterService.timeRemaining(event.startTimestamp)

        case .halftime:
            return .matchStatusHalftime

        case .finished:
            return .matchStatusFulltime
        }
    }

    init(event: Event) {
        self.event = event
    }

    private func statusColor(for teamScore: Int?, comparedTo opponentScore: Int?, isScore: Bool = false) -> EventStatusStyleInfo {
        switch event.status {
        case .inProgress:
            return isScore ? .live : .primary

        case .finished:
            return (teamScore ?? 0) > (opponentScore ?? 0) ? .primary : .secondary

        default:
            return .primary
        }
    }
}
