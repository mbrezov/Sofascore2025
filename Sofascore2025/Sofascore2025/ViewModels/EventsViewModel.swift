//
//  EventsViewModel.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 20.03.2025..
//

import Foundation
import SofaAcademic

class EventsViewModel: EventsViewModelProtocol {

    private let data = Homework3DataSource()

    var onEventsReload: (() -> Void)?

    private(set) var events: [Event] = [] {
        didSet {
            onEventsReload?()
        }
    }

    var leagues: [League] {
        leagueIDs.compactMap { id in
            events.first { $0.league?.id == id }?.league
        }
    }

    private var leagueIDs: [Int] {
        return eventsByLeague.keys.sorted()
    }

    private var eventsByLeague: [Int: [Event]] {
        Dictionary(grouping: events, by: { $0.league?.id ?? 0 })
    }

    func events(for league: League) -> [Event] {
        return events.filter { $0.league?.id == league.id }
    }

    func selectSport(_ sport: SportType) {
        switch sport {
        case .football:
            events = data.events()

        case .basketball:
            events = []

        case .americanFootball:
            events = []
        }
    }
}
