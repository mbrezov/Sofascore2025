//
//  PlayerCellViewModel.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 20.06.2025..
//

import Foundation

class PlayerCellViewModel {

    let name: String?
    let countryName: String?
    let imageUrl: URL?

    init(player: Player) {
        self.name = player.name
        self.countryName = player.country?.name
        self.imageUrl = player.imageUrl?.url
    }
}
