//
//  TournamentsItemCellViewModel.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 20.06.2025..
//

import Foundation

class TournamentsItemCellViewModel {

    let name: String
    let logoURL: URL?

    init(tournament: League) {
        self.name = tournament.name
        self.logoURL = tournament.logoUrl?.url
    }
}
