//
//  SportsCellViewModelProtocol.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 19.06.2025..
//

import Foundation

protocol SportsCellViewModelProtocol {

    var teamId: Int { get }
    var positionText: String { get }
    var teamName: String { get }
    var stats: [StatItem] { get }
    var statisItemsSpacing: CGFloat { get }
}

struct StatItem {

    let label: String
    let value: String
    let labelWidth: CGFloat
}
