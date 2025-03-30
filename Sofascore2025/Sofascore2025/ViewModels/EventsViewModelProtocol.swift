//
//  EventsViewModelProtocol.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 21.03.2025..
//

import Foundation
import SofaAcademic

enum SportType {
    case football, basketball, americanFootball
}

protocol EventsViewModelProtocol {

    var onEventsReload: (() -> Void)? { get set }
    var leagues: [League] { get }
    func events(for league: League) -> [Event]
    func selectSport(_ sport: SportType)
}
