//
//  EventStatusApiNameMapper.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 11.04.2025..
//

import Foundation

enum EventStatusApiNameMapper {

    static func from(apiName: String) -> EventStatus {
        switch apiName {
        case "NOT_STARTED":
            return .notStarted

        case "IN_PROGRESS":
            return .inProgress

        case "HALF_TIME":
            return .halftime

        case "FINISHED":
            return .finished

        default:
            return .notStarted
        }
    }
}
