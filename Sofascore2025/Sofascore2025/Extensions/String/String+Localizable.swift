//
//  String+Localizable.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 12.03.2025..
//

import Foundation

extension String {

    // MARK: - Match status

    static let matchStatusFulltimeShort = "FT"
    static let matchStatusHalftimeShort = "HT"
    static let matchStatusFulltime = "Full Time"
    static let matchStatusHalftime = "Half Time"
    static let matchStatusNotStarted = "-"
    static let scoreDash = "-"

    // MARK: - Sports

    static let football = "Football"
    static let basketball = "Basketball"
    static let americanFootball = "Am. Football"

    // MARK: - EmptyState

    static let emptyStateMessage = "No events available"

    // MARK: - Error

    static let networkErrorTitle = "You're Offline"
    static let networkErrorMessage = "Please check your internet connection and try again."
    static let errorTitle = "Error"
    static let errorMessage = "Something went wrong. Please try again."
    static let URLErrorTitle = "Invalid URL"
    static let URLErrorMessage = "The request URL is malformed. Please verify endpoint formatting and parameters."
    static let decodingErrorTitle = "Decoding failed"
    static let decodingErrorMessage = "The data received from the server couldn't be read. Please check the API format."

    // MARK: - Screen titles

    static let settingsTitle = "Settings"

    // MARK: - Description

    static func roundText(_ value: String) -> String {
        return "Round \(value)"
    }
}
