//
//  APIClientMapper.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 16.04.2025..
//

import Foundation

enum APIClientMapper {

    static func eventStatus(from apiStatus: String) -> EventStatus {
        switch apiStatus {
        case "NOT_STARTED":
            return .notStarted

        case "IN_PROGRESS":
            return .inProgress

        case "HALF_TIME":
            return .halftime

        case "FINISHED":
            return .finished

        default:
            return .unknown
        }
    }

    static func sportAPIName(from sportType: SportType) -> String {
        switch sportType {
        case .football:
            return "football"

        case .basketball:
            return "basketball"

        case .americanFootball:
            return "am-football"
        }
    }

    static func incidentType(from apiStatus: String) -> IncidentType {
        switch apiStatus {
        case "GOAL":
            return .goal

        case "RED_CARD":
            return .redCard

        case "YELLOW_CARD":
            return .yellowCard

        case "PERIOD_END":
            return .periodEnd

        case "FOUL":
            return .periodEnd

        default:
            return .unknown
        }
    }
}
