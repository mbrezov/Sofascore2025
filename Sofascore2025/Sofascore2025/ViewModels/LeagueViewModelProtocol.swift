//
//  LeagueViewModelProtocol.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 13.03.2025..
//

import Foundation

protocol LeagueViewModelProtocol {

    var name: String { get }
    var logoURL: URL? { get }
    var countryName: String? { get }
}
