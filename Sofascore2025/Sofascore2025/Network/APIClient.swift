//
//  APIClient.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 09.04.2025..
//

import Foundation

enum APIClient {

    static func getEvents(for sport: SportType) async throws -> [Event] {
        let urlString = "https://sofa-ios-academy-43194eec0621.herokuapp.com/events?sport=\(sport.rawName)"
        guard let url: URL = .init(string: urlString) else { return [] }

        var request: URLRequest = .init(url: url)
        request.httpMethod = "GET"

        let (data, _) = try await URLSession.shared.data(for: request)
        let response = try JSONDecoder().decode([Event].self, from: data)

        return response
    }
}
