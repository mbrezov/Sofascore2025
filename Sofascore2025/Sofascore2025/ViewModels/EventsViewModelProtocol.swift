//
//  EventsViewModelProtocol.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 21.03.2025..
//

import Foundation

enum SportType: String, CaseIterable {

    case football, basketball, americanFootball
}

protocol EventsViewModelProtocol {

    var onEventsReload: (() -> Void)? { get set }
    var leagues: [LeagueInfo] { get }
    func events(for league: LeagueInfo) -> [EventInfo]
    func selectSport(_ sport: SportType)
}
