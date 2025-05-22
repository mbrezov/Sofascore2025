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
    static let matchStatusUnknown = "Unknown"
    static let matchStatusNotStarted = "-"
    static let scoreDash = "-"

    // MARK: - Sports

    static let football = "Football"
    static let basketball = "Basketball"
    static let americanFootball = "Am. Football"

    // MARK: - EmptyState

    static let eventsEmptyStateMessage = "No events available"

    // MARK: - Error - API

    static let networkErrorTitle = "You're Offline"
    static let networkErrorMessage = "Please check your internet connection and try again."
    static let errorTitle = "Error"
    static let errorMessage = "Something went wrong. Please try again."
    static let URLErrorTitle = "Invalid URL"
    static let URLErrorMessage = "The request URL is malformed. Please verify endpoint formatting and parameters."
    static let decodingErrorTitle = "Decoding failed"
    static let decodingErrorMessage = "The data received from the server couldn't be read. Please check the API format."
    static let unknownEventStatusErrorMessage = "Unknown event status"
    static let unauthorizedAccessErrorTitle = "Session Expired"
    static let unauthorizedAccessErrorMessage = "Please log in again to continue."
    static let invalidResponseErrorTitle = "Invalid server response"
    static let invalidResponseErrorMessage = "Something went wrong. Please try again."
    static let validationErrorTitle = "Validation failed"
    static let validationErrorMessage = "Unable to Process Your Request"
    static let unauthorizedErrorTitle = "Login Failed"
    static let unauthorizedErrorMessage = "Incorrect username or password. Please try again."

    static func serverErrorTitle(_ statusCode: Int) -> String {
        return "Failed to create tables: \(statusCode)"
    }
    static func serverErrorMessage(_ statusCode: Int) -> String {
        return "Failed to create tables: \(statusCode)"
    }

    // MARK: - Error - Image fetching service
    static let emptyCredentialsTitle = "Credentials fields are empty"
    static let emptyCredentialsMessage = "Please enter your credentials."
    static let emptyUsernameTitle = "Username field is empty"
    static let emptyUsernameMessage = "Please enter your username."
    static let emptyPasswordTitle = "Password field is empty"
    static let emptyPasswordMessage = "Please enter your password."

    // MARK: - Error - Keychain

    static func keychainRemoveError(_ error: Error) -> String {
        return "Unable to remove token from keychain: \(error)"
    }

    // MARK: - Error - Database
    static func databaseInitializeError(_ error: Error) -> String {
        return "Failed to initialize database: \(error)"
    }
    static func databaseReadError(_ error: Error) -> String {
        return "Failed to read database: \(error)"
    }
    static func databaseTablesCreatingError(_ error: Error) -> String {
        return "Failed to create tables: \(error)"
    }
    static func databaseInsertRowError(_ error: Error) -> String {
        return "Failed to insert row: \(error)"
    }
    static func databaseDeleteRowsError(_ error: Error) -> String {
        return "Failed to delete all rows: \(error)"
    }

    // MARK: - Error - Image fetching service
    static func imageFetchingServiceFetchingError(_ error: Error) -> String {
        return "Failed to fetch image: \(error)"
    }

    // MARK: - Settings screen

    static let settingsTitle = "Settings"
    static let settingsUnavailable = "Unavailable"
    static let settingsRowUsernameTitle = "USERNAME"
    static let settingsRowLeagueCountTitle = "LEAGUE ROWS"
    static let settingsRowEventsCountTitle = "EVENTS ROWS"

    // MARK: - Description

    static func roundText(_ value: String) -> String {
        return "Round \(value)"
    }

    // MARK: - Login
    static let loginButtonTitle = "Login"
    static let usernameTextFieldPlaceholder = "Username"
    static let passwordTextFieldPlaceholder = "Password"

    // MARK: - Logout
    static let logoutButtonTitle = "Logout"
}
