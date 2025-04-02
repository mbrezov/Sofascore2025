//
//  MainViewModelProtocol.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 01.04.2025..
//

import Foundation

protocol MainViewModelProtocol {

    var eventsViewModel: EventsViewModelProtocol { get }
    func selectSport(_ sport: SportType)
}
