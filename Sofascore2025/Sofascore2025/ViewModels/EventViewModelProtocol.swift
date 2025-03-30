//
//  EventViewModelProtocol.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 13.03.2025..
//

import Foundation
import SofaAcademic

enum MatchStatusColor {
    case live, surfaceLv1, surfaceLv2
}

protocol EventViewModelProtocol {

    var homeTeamLogoURL: URL? { get }
    var awayTeamLogoURL: URL? { get }
    var homeTeamName: String { get }
    var awayTeamName: String { get }
    var leagueName: String? { get }
    var status: EventStatus { get }
    var startTimestamp: String { get }
    var matchStatusDescription: String { get }
    var statusColor: MatchStatusColor { get }
    var homeScore: Int? { get }
    var awayScore: Int? { get }
    var homeTeamColor: MatchStatusColor { get }
    var awayTeamColor: MatchStatusColor { get }
    var homeScoreColor: MatchStatusColor { get }
    var awayScoreColor: MatchStatusColor { get }
}
