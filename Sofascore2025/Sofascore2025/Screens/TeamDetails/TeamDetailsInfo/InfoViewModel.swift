//
//  InfoViewModel.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 20.06.2025..
//

import Foundation

class InfoViewModel {

    var details: TeamInfo?
    var tournaments: [League] = []
    var onInfoUpdated: (() -> Void)?
    var toastErrorAlert: ((String?, String?) -> Void)?
    var isDataFetching: ((Bool) -> Void)?
    let sectionTitles: [String] = [
        .teamInfoSectionTitle,
        .tournamentsSectionTitle,
        .venueSectionTitle
    ]
    var playersCount: Int = 0
    var foreignPlayersCount: Int = 0

    init(teamId: Int) {
        getPlayersCount(teamId)
        getTournaments(teamId)
    }

    func makeInfoCellViewModel() -> InfoCellViewModel? {
        guard let manager = details?.manager else { return nil }
        return InfoCellViewModel(
            manager: manager,
            playersCount: playersCount,
            foreignPlayersCount: foreignPlayersCount
        )
    }

    func makeTournamentsCellViewModel(for tournaments: [League], tournamentsCount: Int) -> TournamentsCellViewModel {
        TournamentsCellViewModel(tournaments: tournaments, tournamentsCount: tournamentsCount)
    }

    func makeVenueCellViewModel() -> VenueCellViewModel? {
        guard let venue = details?.venue else { return nil }
        return VenueCellViewModel(venue: venue)
    }

    private func getPlayersCount(_ id: Int) {
        let squadViewModel = SquadViewModel(teamId: id)
        squadViewModel.onPlayersUpdated = { [weak self] in
            self?.playersCount = squadViewModel.players.count
            self?.foreignPlayersCount = squadViewModel.players.filter { $0.isForeign ?? false }.count
        }
    }

    private func getTournaments(_ id: Int) {
        self.isDataFetching?(true)
        Task {
            do {
                let details = try await APIService.fetchTeamDetails(for: id)
                let tournaments = try await APIService.fetchTeamTournaments(for: id)
                finishTournamentsReload(details, tournaments)
            } catch let error as APIError {
                print(error)
                switch error {
                case .noInternet:
                    print(error.title, error.message)
                    self.finishTournamentsReload(
                        errorTitle: error.title,
                        errorMessage: error.message
                    )

                default:
                    print(error.title, error.message)
                    self.finishTournamentsReload(
                        errorTitle: .errorTitle,
                        errorMessage: .errorMessage
                    )
                }
            }
        }
    }

    private func finishTournamentsReload(
        _ details: TeamInfo? = nil,
        _ tournaments: [League]? = nil,
        errorTitle: String? = nil,
        errorMessage: String? = nil
    ) {
        DispatchQueue.main.async {
            self.details = details
            self.tournaments = tournaments ?? []
            if let title = errorTitle, let message = errorMessage {
                self.toastErrorAlert?(title, message)
            }
            self.onInfoUpdated?()
            self.isDataFetching?(false)
        }
    }
}
