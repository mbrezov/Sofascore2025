//
//  PlayerModelMapper.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 20.06.2025..
//

import Foundation

enum PlayerModelMapper {

    static func makePlayer(from apiPlayer: APIPlayer) -> Player {
        Player(
            id: apiPlayer.id,
            name: apiPlayer.name,
            shortName: apiPlayer.shortName,
            position: apiPlayer.position,
            jerseyNumber: apiPlayer.jerseyNumber,
            country: Country(name: apiPlayer.country?.name),
            imageUrl: apiPlayer.imageUrl,
            isForeign: apiPlayer.isForeign
        )
    }
}
