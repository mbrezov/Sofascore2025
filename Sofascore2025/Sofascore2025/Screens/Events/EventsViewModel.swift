//
//  EventsViewModel.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 20.03.2025..
//

import Foundation

class EventsViewModel {

    var isDataFetching: ((Bool) -> Void)?
    var toastErrorAlert: ((String?, String?) -> Void)?
    var onEventsReload: (() -> Void)?

    private var events: [EventCellViewModel] = []
    private(set) var leagues: [League] = []
    private(set) var selectedSportType: SportType?
    private var eventModels: [Event] = []

    func makeLeagueHeaderViewModel(from league: League) -> LeagueHeaderViewModel {
        LeagueHeaderViewModel(league: league)
    }

    func makeEventDetailsViewModel(for eventCellViewModel: EventCellViewModel) -> EventDetailsViewModel? {
        guard let event = eventModels.first(where: { $0.id == eventCellViewModel.id }) else { return nil }
        let eventDetailsViewModel = EventDetailsViewModel(
            event: event,
            sportType: self.selectedSportType
        )
        return eventDetailsViewModel
    }

    func makeLeagueDetailsViewModel(for leagueId: Int) -> LeagueDetailsViewModel? {
        guard let league = eventModels.first(where: { $0.league?.id == leagueId })?.league else { return nil }
        let leaueDetailsViewModel = LeagueDetailsViewModel(
            league: league,
            sportType: self.selectedSportType
        )
        return leaueDetailsViewModel
    }

    func getEvents(for league: League) -> [EventCellViewModel] {
        events.filter { $0.leagueId == league.id }
    }

    func selectSport(_ sportType: SportType) {
        self.selectedSportType = sportType
        self.isDataFetching?(true)

        Task { [weak self] in
            do {
                let eventModels = try await APIService.fetchEvents(for: sportType)
                self?.finishEventsReload(with: eventModels)
            } catch let error as APIError {
                let cachedEventModels = DatabaseService.readEvents(for: sportType)
                switch error {
                case .noInternet:
                    self?.finishEventsReload(
                        with: cachedEventModels,
                        errorTitle: error.title,
                        errorMessage: error.message
                    )

                default:
                    self?.finishEventsReload(with: cachedEventModels)
                    print(error.title, error.message)
                }
            }
        }
    }

    private func finishEventsReload(
        with events: [Event]? = nil,
        errorTitle: String? = nil,
        errorMessage: String? = nil
    ) {
        DispatchQueue.main.async {
            self.setEvents(with: events ?? [])
            if let title = errorTitle, let message = errorMessage {
                self.toastErrorAlert?(title, message)
            }
            self.isDataFetching?(false)
        }
    }

    private func setEvents(with eventModels: [Event]) {
        self.eventModels = eventModels
        events = eventModels.map { EventCellViewModel(event: $0) }
        let eventsByLeague = Dictionary(grouping: eventModels, by: { $0.league?.id ?? 0 })
        let leagueIDs = eventsByLeague.keys.sorted()

        leagues = leagueIDs.compactMap { id in
            guard let league = eventModels.first(where: { $0.league?.id == id })?.league else { return nil }
            return league
        }
        self.onEventsReload?()
    }
}
