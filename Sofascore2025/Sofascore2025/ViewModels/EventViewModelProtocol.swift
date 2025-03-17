//
//  EventViewModelProtocol.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 13.03.2025..
//

import Foundation
import SofaAcademic

protocol EventViewModelProtocol {

    var homeTeamLogoUrl: URL? { get}
    var awayTeamLogoUrl: URL? { get }
    var homeTeamName: String { get }
    var awayTeamName: String { get }
    var leagueName: String? { get }
    var status: EventStatus { get }
    var startTimestamp: String { get }
    var homeScore: Int? { get }
    var awayScore: Int? { get}

    var matchStatusDescription: String { get }
}
