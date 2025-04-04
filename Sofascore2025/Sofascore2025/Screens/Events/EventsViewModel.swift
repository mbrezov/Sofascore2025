//
//  EventsViewModel.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 20.03.2025..
//

import Foundation
import SofaAcademic

class EventsViewModel {

    private let dataSource = Homework3DataSource()

    var onEventsReload: (() -> Void)?

    private(set) var rawEvents: [Event] {
        didSet {
            onEventsReload?()
        }
    }

    private var events: [EventViewModel] {
        rawEvents.map { EventViewModel(event: $0) }
    }

    var leagues: [LeagueViewModel] {
        leagueIDs.compactMap { id in
            guard let league = rawEvents.first(where: { $0.league?.id == id })?.league else { return nil }
            return LeagueViewModel(league: league)
        }
    }

    private var leagueIDs: [Int] {
        eventsByLeague.keys.sorted()
    }

    private var eventsByLeague: [Int: [Event]] {
        Dictionary(grouping: rawEvents, by: { $0.league?.id ?? 0 })
    }

    init() {
        self.rawEvents = dataSource.events()
    }

    func events(for league: LeagueViewModel) -> [EventViewModel] {
        return events.filter { $0.leagueId == league.id }
    }

    func selectSport(_ sport: SportType) {
        switch sport {
        case .football:
            rawEvents = dataSource.events()

        case .basketball:
            rawEvents = []

        case .americanFootball:
            rawEvents = []
        }
    }
}
