//
//  EventsViewModel.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 20.03.2025..
//

import Foundation

class EventsViewModel {

    var onEventsReload: (() -> Void)?
    var isDataFetching: ((Bool) -> Void)?

    private var events: [EventViewModel] = []
    private(set) var leagues: [LeagueHeaderViewModel] = []

    func getEvents(for league: LeagueHeaderViewModel) -> [EventViewModel] {
        events.filter { $0.leagueId == league.id }
    }

    func selectSport(_ sport: SportType) {
        Task { [weak self] in
            guard let self = self else { return }

            self.isDataFetching?(true)
            self.leagues = []

            guard let eventModels: [Event] = try? await APIClient.getEvents(for: sport) else {
                return
            }

            setEvents(with: eventModels)
            self.isDataFetching?(false)
        }
    }

    private func setEvents(with eventModels: [Event]) {
        events = eventModels.map { EventViewModel(event: $0) }
        let eventsByLeague = Dictionary(grouping: eventModels, by: { $0.league?.id ?? 0 })
        let leagueIDs = eventsByLeague.keys.sorted()

        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }

            self.leagues = leagueIDs.compactMap { id in
                guard let league = eventModels.first(where: { $0.league?.id == id })?.league else { return nil }
                return LeagueHeaderViewModel(league: league)
            }
            self.onEventsReload?()
        }
    }
}
