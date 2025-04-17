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
    }

    private enum QueryItems {
        static let sport = "sport"
    }

    private static var eventsURL: String {
        "\(scheme)://\(baseURL)\(Endpoints.events)"
    }

    static func makeEventsURL(for sportName: String) -> URL? {
        var components = URLComponents()
        components.scheme = scheme
        components.host = baseURL
        components.path = Endpoints.events
        components.queryItems = [
            URLQueryItem(name: QueryItems.sport, value: sportName)
        ]
        return components.url
    }
}
