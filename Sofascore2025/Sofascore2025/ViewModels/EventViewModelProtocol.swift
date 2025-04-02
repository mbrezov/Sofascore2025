//
//  EventViewModelProtocol.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 13.03.2025..
//

import Foundation

protocol EventViewModelProtocol {

    var homeTeamInfo: EventTeamInfo { get }
    var awayTeamInfo: EventTeamInfo { get }
    var statusInfo: EventStatusInfo { get }
    var leagueName: String? { get }
}
