//
//  TeamViewInfo.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 02.04.2025..
//

import Foundation
import SofaAcademic

public struct TeamInfo {

    let id: Int
    let name: String
    let logoURL: URL?

    init(for team: Team) {
        self.id = team.id
        self.name = team.name
        self.logoURL = team.logoUrl?.url
    }
}
