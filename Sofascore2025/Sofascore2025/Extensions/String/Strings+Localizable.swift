//
//  Strings+Localizable.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 12.03.2025..
//

import Foundation

extension String {

    static let matchStatusFulltime = "Full Time"
    static let matchStatusHalftime = "Half Time"
    static let matchStatusNotStarted = "-"
    static let scoreDash = "-"

    static let football = "Football"
    static let basketball = "Basketball"
    static let americanFootball = "Am. Football"

    static let emptyStateMessage = "No events available"

    static let settingsTitle = "Settings"

    var round: String {
        "Round \(self)"
    }
}
