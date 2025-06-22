//
//  SquadViewModel.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 20.06.2025..
//

import Foundation

class SquadViewModel {

    var players: [Player] = []
    var onPlayersUpdated: (() -> Void)?

    init(teamId: Int) {
        getPlayers(teamId)
    }

    func makePlayerCellViewModel(for player: Player) -> PlayerCellViewModel {
        let playerCellViewModel = PlayerCellViewModel(
            player: player
        )
        return playerCellViewModel
    }

    private func getPlayers(_ id: Int) {
        Task {
            do {
                let players = try await APIService.fetchTeamPlayers(for: id)
                finishPlayersReload(with: players)
            } catch let error as APIError {
                print(error)
                switch error {
                case .noInternet:
                    print(error.title, error.message)
                    self.finishPlayersReload(
                        errorTitle: error.title,
                        errorMessage: error.message
                    )

                default:
                    print(error.title, error.message)
                    self.finishPlayersReload(
                        errorTitle: error.title,
                        errorMessage: error.message
                    )
                }
            }
        }
    }

    private func finishPlayersReload(
        with players: [Player]? = nil,
        errorTitle: String? = nil,
        errorMessage: String? = nil
    ) {
        DispatchQueue.main.async {
            self.players = players ?? []
            self.onPlayersUpdated?()
        }
    }
}
