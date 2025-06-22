//
//  MatchesViewModel.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 13.06.2025..
//

import Foundation

class MatchesViewModel {

    private let league: League

    let id: Int
    let name: String
    let logoURL: URL?
    let countryName: String?
    let sportType: SportType?

    var leagueMatches: [Event] = []
    var onLeagueMatchesUpdated: (() -> Void)?
    var toastErrorAlert: ((String?, String?) -> Void)?
    var isDataFetching: ((Bool) -> Void)?

    init(league: League, sportType: SportType?) {
        self.league = league
        self.id = league.id
        self.name = league.name
        self.logoURL = league.logoUrl?.url
        self.countryName = league.country.name
        self.sportType = sportType

        getLeagueMatches(league.id)
    }

    var rounds: [Int] {
        let rounds = leagueMatches.compactMap { $0.round }
        return Array(Set(rounds)).sorted()
    }

    func events(for round: Int) -> [Event] {
        leagueMatches.filter { $0.round == round }
    }

    func makeEventDetailsViewModel(for event: Event) -> EventDetailsViewModel? {
        let eventDetailsViewModel = EventDetailsViewModel(
            event: event,
            sportType: sportType
        )
        return eventDetailsViewModel
    }

    private func getLeagueMatches(_ id: Int) {
        self.isDataFetching?(true)
        Task {
            do {
                let leagueMatches = try await APIService.fetchLeagueMatches(for: id)
                finishLeagueMatchesReload(with: leagueMatches)
            } catch let error as APIError {
                print(error)
                switch error {
                case .noInternet:
                    print(error.title, error.message)
                    self.finishLeagueMatchesReload(
                        errorTitle: error.title,
                        errorMessage: error.message
                    )

                default:
                    print(error.title, error.message)
                    self.finishLeagueMatchesReload(
                        errorTitle: error.title,
                        errorMessage: error.message
                    )
                }
            }
        }
    }

    private func finishLeagueMatchesReload(
        with leagueMatches: [Event]? = nil,
        errorTitle: String? = nil,
        errorMessage: String? = nil
    ) {
        DispatchQueue.main.async {
            self.leagueMatches = leagueMatches ?? []
            if let title = errorTitle, let message = errorMessage {
                self.toastErrorAlert?(title, message)
            }
            self.onLeagueMatchesUpdated?()
            self.isDataFetching?(false)
        }
    }
}
