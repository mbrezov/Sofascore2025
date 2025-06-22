//
//  APIClient.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 09.04.2025..
//

import Foundation

enum APIClient {

    // MARK: - Events methods

    static func getEvents(for sportType: SportType) async throws -> [APIEvent] {
        let sportName: String = APIClientMapper.sportAPIName(from: sportType)
        guard let url: URL = APIDefinitions.makeEventsURL(for: sportName) else {
            throw APIError.invalidURL
        }
        guard let token = KeychainService.loadToken(forKey: .authToken) else {
            throw APIError.unauthorizedAccess
        }

        var request: URLRequest = .init(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            return try JSONDecoder().decode([APIEvent].self, from: data)
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

    static func getEvent(for id: Int) async throws -> APIEvent {
        guard let url: URL = APIDefinitions.makeEventURL(for: id) else {
            throw APIError.invalidURL
        }
        guard let token = KeychainService.loadToken(forKey: .authToken) else {
            throw APIError.unauthorizedAccess
        }

        var request: URLRequest = .init(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            return try JSONDecoder().decode(APIEvent.self, from: data)
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

    static func getEventIncidents(for id: Int) async throws -> [APIIncident] {
        guard let url: URL = APIDefinitions.makeEventIncidentsURL(for: id) else {
            throw APIError.invalidURL
        }
        guard let token = KeychainService.loadToken(forKey: .authToken) else {
            throw APIError.unauthorizedAccess
        }

        var request: URLRequest = .init(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            return try JSONDecoder().decode([APIIncident].self, from: data)
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

    // MARK: - League methods

    static func getLeagueMathes(for id: Int) async throws -> [APIEvent] {
        guard let url: URL = APIDefinitions.makeLeagueMathesURL(for: id) else {
            throw APIError.invalidURL
        }
        guard let token = KeychainService.loadToken(forKey: .authToken) else {
            throw APIError.unauthorizedAccess
        }

        var request: URLRequest = .init(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            return try JSONDecoder().decode([APIEvent].self, from: data)
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

    static func getLeagueStandings(for id: Int) async throws -> [APIStandings] {
        guard let url: URL = APIDefinitions.makeLeagueStandingsURL(for: id) else {
            throw APIError.invalidURL
        }
        guard let token = KeychainService.loadToken(forKey: .authToken) else {
            throw APIError.unauthorizedAccess
        }

        var request: URLRequest = .init(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            return try JSONDecoder().decode([APIStandings].self, from: data)
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

    // MARK: - Team methods

    static func getTeamDetails(for id: Int) async throws -> APITeamInfo {
        guard let url: URL = APIDefinitions.makeTeamDetailsURL(for: id) else {
            throw APIError.invalidURL
        }
        guard let token = KeychainService.loadToken(forKey: .authToken) else {
            throw APIError.unauthorizedAccess
        }

        var request: URLRequest = .init(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            return try JSONDecoder().decode(APITeamInfo.self, from: data)
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

    static func getTeamPlayers(for id: Int) async throws -> [APIPlayer] {
        guard let url: URL = APIDefinitions.makeTeamPlayersURL(for: id) else {
            throw APIError.invalidURL
        }
        guard let token = KeychainService.loadToken(forKey: .authToken) else {
            throw APIError.unauthorizedAccess
        }

        var request: URLRequest = .init(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            return try JSONDecoder().decode([APIPlayer].self, from: data)
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

    static func getTeamTournaments(for id: Int) async throws -> [APILeague] {
        guard let url: URL = APIDefinitions.makeTeamTournamentsURL(for: id) else {
            throw APIError.invalidURL
        }
        guard let token = KeychainService.loadToken(forKey: .authToken) else {
            throw APIError.unauthorizedAccess
        }

        var request: URLRequest = .init(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            return try JSONDecoder().decode([APILeague].self, from: data)
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

    // MARK: - Login call

    static func login(username: String, password: String) async throws -> APIAuthResponse {
        guard let url: URL = APIDefinitions.makeLoginURL() else {
            throw APIError.invalidURL
        }

        var request: URLRequest = .init(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: String] = [
            "username": username,
            "password": password
        ]

        do {
            request.httpBody = try JSONEncoder().encode(body)
            let (data, response) = try await URLSession.shared.data(for: request)

            guard let httpResponse = response as? HTTPURLResponse else {
                throw APIError.invalidResponse
            }

            switch httpResponse.statusCode {
            case 200...299:
                return try JSONDecoder().decode(APIAuthResponse.self, from: data)

            case 401:
                throw APIError.unauthorized

            default:
                throw APIError.serverError(httpResponse.statusCode)
            }
        } catch {
            if let apiError = error as? APIError {
                throw apiError
            } else if let urlError = error as? URLError {
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
