//
//  EventStatusInfoMapper.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 11.04.2025..
//

import Foundation

enum EventStatusInfoMapper {

    static func makeStatusInfo(from event: Event) -> EventStatusInfo {
        let description: String
        let descriptionShort: String
        let status = APIClientMapper.eventStatus(from: event.status)

        switch status {
        case .notStarted:
            description = .matchStatusNotStarted
            descriptionShort = description

        case .inProgress:
            description = DateFormatterService.timeRemaining(event.startTimestamp)
            descriptionShort = description

        case .halftime:
            description = .matchStatusHalftime
            descriptionShort = .matchStatusHalftimeShort

        case .finished:
            description = .matchStatusFulltime
            descriptionShort = .matchStatusFulltimeShort
        }

        return EventStatusInfo(
            status: APIClientMapper.eventStatus(from: event.status),
            description: description,
            descriptionShort: descriptionShort,
            startTimeText: DateFormatterService.timeFormatted(event.startTimestamp),
            color: status == .inProgress ? .live : .secondary
        )
    }
}
