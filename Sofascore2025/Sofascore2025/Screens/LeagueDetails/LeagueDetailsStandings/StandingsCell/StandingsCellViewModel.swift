//
//  StandingsCellViewModel.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 19.06.2025..
//

import Foundation

class StandingsCellViewModel {

    private let stadings: Standings
    private let sportType: SportType?

    init(standings: Standings, sportType: SportType?) {
        self.stadings = standings
        self.sportType = sportType
    }

    func makeSportCellViewModel() -> SportsCellViewModelProtocol? {
        guard let sportType = sportType else { return nil }
        switch sportType {
        case .football:
            return FootballStandingsCellViewModel(standings: stadings)

        case .basketball:
            return BasketballStandingsCellViewModel(standings: stadings)

        case .americanFootball:
            return AmFootballStandingsCellViewModel(standings: stadings)
        }
    }
}
