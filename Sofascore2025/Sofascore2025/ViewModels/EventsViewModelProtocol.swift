//
//  EventsViewModelProtocol.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 21.03.2025..
//

import Foundation
import SofaAcademic

protocol EventsViewModelProtocol {

    var eventsByLeague: [Int?: [Event]] { get }
    var leagueIDs: [Int?] { get }

    func getLeague(by id: Int?) -> League?
}
