//
//  StandingsViewModel.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 13.06.2025..
//

import Foundation

class StandingsViewModel {

    let leagueId: Int
    let sportType: SportType?
    var leagueStandings: [Standings] = []

    init(leagueId: Int, sportType: SportType?) {
        self.leagueId = leagueId
        self.sportType = sportType

        getLeagueStandings(leagueId)
    }

    func makeStandingsCellViewModel(for standings: Standings) -> StandingsCellViewModel {
        let standingsCellViewModel = StandingsCellViewModel(
            standings: standings,
            sportType: sportType
        )
        return standingsCellViewModel
    }

    private func getLeagueStandings(_ id: Int) {
        Task {
            do {
                let leagueStandings = try await APIService.fetchLeagueStandings(for: id)
                finishLeagueStandingsReload(with: leagueStandings)
            } catch let error as APIError {
                print(error)
                switch error {
                case .noInternet:
                    print(error.title, error.message)
                    self.finishLeagueStandingsReload(
                        errorTitle: error.title,
                        errorMessage: error.message
                    )

                default:
                    print(error.title, error.message)
                    self.finishLeagueStandingsReload(
                        errorTitle: error.title,
                        errorMessage: error.message
                    )
                }
            }
        }
    }

    private func finishLeagueStandingsReload(
        with leagueStandings: [Standings]? = nil,
        errorTitle: String? = nil,
        errorMessage: String? = nil
    ) {
        DispatchQueue.main.async {
            self.leagueStandings = leagueStandings ?? []
        }
    }
}
