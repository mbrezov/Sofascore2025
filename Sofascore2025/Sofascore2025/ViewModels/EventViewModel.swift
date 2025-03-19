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

    init(event: Event) {
        self.event = event
    }
}
