//
//  EventDetailsViewModel.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 09.04.2025..
//

import Foundation

class EventDetailsViewModel {

    private let event: EventViewModel

    let country: String?
    let leagueName: String?
    let leagueLogoURL: URL?
    let homeTeamInfo: EventTeamInfo
    let awayTeamInfo: EventTeamInfo
    let dateText: String
    let startTimeText: String
    let statusInfo: EventStatusInfo
    let isNotStarted: Bool

    init(event: EventViewModel) {
        self.event = event

        self.country = event.leagueCountry
        self.leagueName = event.leagueName
        self.leagueLogoURL = event.logoURL
        self.homeTeamInfo = event.homeTeamInfo
        self.awayTeamInfo = event.awayTeamInfo
        self.dateText = DateFormatterService.fullDateFormatted(event.startTimestamp)
        self.startTimeText = DateFormatterService.timeFormatted(event.startTimestamp)
        self.statusInfo = event.statusInfo
        self.isNotStarted = event.statusInfo.status == .notStarted
    }
}
