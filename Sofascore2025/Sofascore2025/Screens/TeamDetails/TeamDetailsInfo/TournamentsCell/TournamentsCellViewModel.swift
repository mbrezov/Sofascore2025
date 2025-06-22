//
//  TournamentsCellViewModel.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 20.06.2025..
//

import Foundation

class TournamentsCellViewModel {

    let tournamentsCount: Int
    let tournaments: [League]

    init(tournaments: [League], tournamentsCount: Int) {
        self.tournaments = tournaments
        self.tournamentsCount = tournamentsCount
    }

    func makeTournamentsItemCellViewModel(for tournament: League) -> TournamentsItemCellViewModel {
        TournamentsItemCellViewModel(tournament: tournament)
    }

    func estimatedHeight(forWidth width: CGFloat) -> CGFloat {
        let itemsPerRow: CGFloat = 3
        let rowCount = ceil(CGFloat(tournamentsCount) / itemsPerRow)
        let itemHeight: CGFloat = 96

        return (rowCount * itemHeight)
    }
}
