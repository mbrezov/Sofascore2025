//
//  EventsViewModel.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 20.03.2025..
//

import Foundation

class EventsViewModel: EventsViewModelProtocol {

    private let allEvents: [EventInfo]

    var onEventsReload: (() -> Void)?

    private(set) var events: [EventInfo] {
        didSet {
            onEventsReload?()
        }
    }

    var leagues: [LeagueInfo] {
        leagueIDs.compactMap { id in
            guard let event = events.first(where: { $0.league?.id == id }) else { return nil }
            return event.league
        }
    }

    private var leagueIDs: [Int] {
        return eventsByLeague.keys.sorted()
    }

    private var eventsByLeague: [Int: [EventInfo]] {
        Dictionary(grouping: events, by: { $0.league?.id ?? 0 })
    }

    init(events: [EventInfo]) {
        self.allEvents = events
        self.events = events
    }

    func events(for league: LeagueInfo) -> [EventInfo] {
        return events.filter { $0.league?.id == league.id }
    }

    func selectSport(_ sport: SportType) {
        switch sport {
        case .football:
            events = allEvents

        case .basketball:
            events = []

        case .americanFootball:
            events = []
        }
    }
}
