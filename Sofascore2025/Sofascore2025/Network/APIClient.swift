//
//  APIClient.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 09.04.2025..
//

import Foundation

enum APIClient {

    static func getEvents(for sportType: SportType) async throws -> [Event] {
        let sportName: String = APIClientMapper.sportAPIName(from: sportType)
        guard let url: URL = APIDefinitions.makeEventsURL(for: sportName) else {
            throw APIError.invalidURL
        }

        var request: URLRequest = .init(url: url)
        request.httpMethod = "GET"

        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            return try JSONDecoder().decode([Event].self, from: data)
        } catch {
            if let urlError = error as? URLError {
                if urlError.code == .notConnectedToInternet {
                    throw APIError.noInternet
                }
            } else if error is DecodingError {
                throw APIError.decodingFailed
            }
            throw APIError.unknown(error)
        }
    }
}
