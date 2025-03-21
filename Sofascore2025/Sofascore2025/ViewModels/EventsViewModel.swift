//
//  EventsViewModel.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 20.03.2025..
//

import Foundation
import SofaAcademic

class EventsViewModel: EventsViewModelProtocol {

    private let events: [Event]

    var eventsByLeague: [Int?: [Event]] {
        Dictionary(grouping: events, by: { $0.league?.id })
    }

    var leagueIDs: [Int?] {
        eventsByLeague.keys.compactMap { $0 }.sorted()
    }

    init(events: [Event]) {
        self.events = events
    }

    func getLeague(by id: Int?) -> League? {
        events.compactMap(\.league).first(where: { $0.id == id })
    }
}
