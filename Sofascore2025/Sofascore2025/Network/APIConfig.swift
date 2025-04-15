//
//  APIConfig.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 15.04.2025..
//

import Foundation

enum APIConfig {

    static let scheme: String = "https"
    static let baseURL: String = "sofa-ios-academy-43194eec0621.herokuapp.com"

    enum Endpoints {
        static let events = "/events"
    }

    enum QueryItems {
        static let sport = "sport"
    }

    static var eventsURL: String {
        "\(scheme)://\(baseURL)\(Endpoints.events)"
    }

    static func makeEventsURL(for sportName: String) -> URL? {
        var components = URLComponents()
        components.scheme = APIConfig.scheme
        components.host = APIConfig.baseURL
        components.path = Endpoints.events
        components.queryItems = [
            URLQueryItem(name: QueryItems.sport, value: sportName)
        ]
        return components.url
    }
}
