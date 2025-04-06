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

    private var events: [EventViewModel] = []
    private(set) var leagues: [LeagueHeaderViewModel] = []

    func getEvents(for league: LeagueHeaderViewModel) -> [EventViewModel] {
        events.filter { $0.leagueId == league.id }
    }

    func selectSport(_ sport: SportType) {
        let eventModels: [Event]

        switch sport {
        case .football:
            eventModels = dataSource.events()

        case .basketball:
            eventModels = []

        case .americanFootball:
            eventModels = []
        }

        events = eventModels.map { EventViewModel(event: $0) }
        let eventsByLeague = Dictionary(grouping: eventModels, by: { $0.league?.id ?? 0 })

        let leagueIDs = eventsByLeague.keys.sorted()
        leagues = leagueIDs.compactMap { id in
            guard let league = eventModels.first(where: { $0.league?.id == id })?.league else { return nil }
            return LeagueHeaderViewModel(league: league)
        }

        onEventsReload?()
    }
}
