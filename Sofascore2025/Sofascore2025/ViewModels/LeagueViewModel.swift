//
//  LeagueViewModel.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 11.03.2025..
//

import Foundation
import SofaAcademic

class LeagueViewModel: LeagueViewModelProtocol {

    private let league: League

    var leagueName: String { league.name }
    var country: Country? { league.country }

    init(league: League) {
        self.league = league
    }

    func fetchLeagueLogo(completion: @escaping (Data?) -> Void) {
        ImageFetchingService.fetchImage(from: league.logoUrl, completion: completion)
    }
}
