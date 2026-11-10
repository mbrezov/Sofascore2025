//
//  APIDefinitions.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 15.04.2025..
//

import Foundation

enum APIDefinitions {

    private static let scheme: String = "https"
    private static let baseURL: String = "sofa-ios-academy-43194eec0621.herokuapp.com"

    private enum Endpoints {
        static let events = "/events"
        static let leagues = "/leagues"
        static let teams = "/teams"
        static let login = "/login"

        static func event(id: Int) -> String {
            "\(events)/\(id)"
        }

        static func eventIncidents(id: Int) -> String {
            "\(events)/\(id)/incidents"
        }

        static func leagueMatches(id: Int) -> String {
            "\(leagues)/\(id)/matches"
        }

        static func leagueStandings(id: Int) -> String {
            "\(leagues)/\(id)/standings"
        }

        static func teamDetails(id: Int) -> String {
            "\(teams)/\(id)"
        }

        static func teamPlayers(id: Int) -> String {
            "\(teams)/\(id)/players"
        }

        static func teamTournaments(id: Int) -> String {
            "\(teams)/\(id)/tournaments"
        }
    }

    private enum QueryItems {
        static let sport = "sport"
    }

    private static var eventsURL: String {
        "\(scheme)://\(baseURL)\(Endpoints.events)"
    }

    private static func makeURL(
        _ path: String,
        queryParameters: (name: String, value: String)? = nil
    ) -> URL? {
        var components = URLComponents()
        components.scheme = scheme
        components.host = baseURL
        components.path = path

        guard let queryParameters = queryParameters else { return components.url }
        components.queryItems = [
            URLQueryItem(name: queryParameters.name, value: queryParameters.value)
        ]
        return components.url
    }

    // MARK: - Event URL

    static func makeEventsURL(for sportName: String) -> URL? {
        makeURL(Endpoints.events, queryParameters: (QueryItems.sport, sportName))
    }

    static func makeEventURL(for id: Int) -> URL? {
        makeURL(Endpoints.event(id: id))
    }

    static func makeEventIncidentsURL(for id: Int) -> URL? {
        makeURL(Endpoints.eventIncidents(id: id))
    }

    // MARK: - League URL

    static func makeLeagueMathesURL(for id: Int) -> URL? {
        makeURL(Endpoints.leagueMatches(id: id))
    }

    static func makeLeagueStandingsURL(for id: Int) -> URL? {
        makeURL(Endpoints.leagueStandings(id: id))
    }

    // MARK: - Team URL

    static func makeTeamDetailsURL(for id: Int) -> URL? {
        makeURL(Endpoints.teamDetails(id: id))
    }

    static func makeTeamPlayersURL(for id: Int) -> URL? {
        makeURL(Endpoints.teamPlayers(id: id))
    }

    static func makeTeamTournamentsURL(for id: Int) -> URL? {
        makeURL(Endpoints.teamTournaments(id: id))
    }

    // MARK: - Login URL

    static func makeLoginURL() -> URL? {
        makeURL(Endpoints.login)
    }
}
