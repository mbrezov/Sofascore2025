//
//  APIService.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 28.04.2025..
//

import Foundation

enum APIService {

    static func fetchEvents(for sportType: SportType) async throws -> [Event]? {
        let apiEvents: [APIEvent] = try await APIClient.getEvents(for: sportType)
        let events: [Event] = apiEvents.map { EventModelMapper.makeEvent(from: $0) }
        return DatabaseService.saveEventsData(events, sportType)
    }

    static func login(username: String?, password: String?) async throws -> APIAuthResponse? {
        let validatedUsername: String
        let validatedPassword: String

        (validatedUsername, validatedPassword) = try AuthCredentialsValidationService.validate(username, password)

        let response = try await APIClient.login(username: validatedUsername, password: validatedPassword)
        return response
    }
}
