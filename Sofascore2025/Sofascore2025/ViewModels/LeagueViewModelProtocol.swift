//
//  LeagueViewModelProtocol.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 13.03.2025..
//

import Foundation
import SofaAcademic

protocol LeagueViewModelProtocol {

    var leagueName: String { get}
    var leagueLogoUrl: URL? { get }
    var country: Country? { get }
}
