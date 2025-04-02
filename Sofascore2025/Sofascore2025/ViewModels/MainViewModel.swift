//
//  MainViewModel.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 01.04.2025..
//

import Foundation
import SofaAcademic

class MainViewModel: MainViewModelProtocol {

    private let dataSource: Homework3DataSource

    let eventsViewModel: EventsViewModelProtocol

    init(dataSource: Homework3DataSource = Homework3DataSource()) {
        self.dataSource = dataSource
        let events = dataSource.events().map{ EventInfo(event: $0) }
        self.eventsViewModel = EventsViewModel(events: events)
    }

    func selectSport(_ sport: SportType) {
        eventsViewModel.selectSport(sport)
    }
}
