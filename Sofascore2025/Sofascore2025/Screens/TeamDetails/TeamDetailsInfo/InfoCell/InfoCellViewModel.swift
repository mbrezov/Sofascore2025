//
//  InfoCellViewModel.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 20.06.2025..
//

import Foundation

class InfoCellViewModel {

    let name: String
    let countryName: String?
    let imageUrl: URL?
    let playersCountText: String
    let foreignPlayersCountText: String

    init(manager: TeamManager, playersCount: Int, foreignPlayersCount: Int) {
        self.name = String.coachText(manager.name)
        self.countryName = manager.country?.name
        self.imageUrl = manager.imageUrl.url
        self.playersCountText = String(playersCount)
        self.foreignPlayersCountText = String(foreignPlayersCount)
    }
}
