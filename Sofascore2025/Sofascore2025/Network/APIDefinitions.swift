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
        static let events = "/secure/events"
        static let login = "/login"
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

    static func makeEventsURL(for sportName: String) -> URL? {
        makeURL(Endpoints.events, queryParameters: (QueryItems.sport, sportName))
    }

    static func makeLoginURL() -> URL? {
        makeURL(Endpoints.login)
    }
}
