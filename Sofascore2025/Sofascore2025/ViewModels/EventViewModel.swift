//
//  EventViewModel.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 11.03.2025..
//

import Foundation

class EventViewModel: EventViewModelProtocol {

    private let event: EventInfo

    var homeTeamInfo: EventTeamInfo { teamInfo(for: event.homeTeam, score: event.homeScore, opponentScore: event.awayScore) }
    var awayTeamInfo: EventTeamInfo { teamInfo(for: event.awayTeam, score: event.awayScore, opponentScore: event.homeScore) }

    var statusInfo: EventStatusInfo {
        EventStatusInfo(
            description: matchStatusDescription,
            startTimestamp: DateFormatterService.timeFormatted(event.startTimestamp),
            style: event.status == .inProgress ? .live : .secondary
        )
    }

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

    init(event: EventInfo) {
        self.event = event
    }

    private func teamInfo(for team: TeamInfo, score: Int?, opponentScore: Int?) -> EventTeamInfo {
        EventTeamInfo(
            logoURL: team.logoURL,
            name: team.name,
            score: score,
            style: statusColor(for: score, comparedTo: opponentScore),
            scoreStyle: statusColor(for: score, comparedTo: opponentScore, isScore: true)
        )
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
