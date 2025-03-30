//
//  EventViewModel.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 11.03.2025..
//

import Foundation
import SofaAcademic

class EventViewModel: EventViewModelProtocol {

    private let event: Event

    var homeTeamLogoURL: URL? { event.homeTeam.logoUrl?.url }
    var awayTeamLogoURL: URL? { event.awayTeam.logoUrl?.url }
    var homeTeamName: String { event.homeTeam.name }
    var awayTeamName: String { event.awayTeam.name }
    var leagueName: String? { event.league?.name }
    var status: EventStatus { event.status }
    var startTimestamp: String { DateFormatterService.timeFormatted(event.startTimestamp) }
    var homeScore: Int? { event.homeScore }
    var awayScore: Int? { event.awayScore }

    var matchStatusDescription: String {
        switch status {
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

    var statusColor: MatchStatusColor {
        status == .inProgress ? .live : .surfaceLv2
    }

    var homeTeamColor: MatchStatusColor {
        statusColor(for: homeScore, comparedTo: awayScore)
    }

    var awayTeamColor: MatchStatusColor {
        statusColor(for: awayScore, comparedTo: homeScore)
    }

    var homeScoreColor: MatchStatusColor {
        statusColor(for: homeScore, comparedTo: awayScore, isScore: true)
    }

    var awayScoreColor: MatchStatusColor {
        statusColor(for: awayScore, comparedTo: homeScore, isScore: true)
    }

    init(event: Event) {
        self.event = event
    }

    private func statusColor(for teamScore: Int?, comparedTo opponentScore: Int?, isScore: Bool = false) -> MatchStatusColor {
        switch status {
        case .inProgress:
            return isScore ? .live : .surfaceLv1

        case .finished:
            return (teamScore ?? 0) > (opponentScore ?? 0) ? .surfaceLv1 : .surfaceLv2

        default:
            return .surfaceLv1
        }
    }
}
