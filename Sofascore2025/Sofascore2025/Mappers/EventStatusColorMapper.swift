//
//  EventStatusColorMapper.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 11.04.2025..
//

import Foundation

enum EventStatusColorMapper {

    static func statusColor(for score: Int?, comparedTo opponentScore: Int?, status: EventStatus, isScore: Bool = false) -> EventStatusColor {
        switch status {
        case .inProgress:
            return isScore ? .live : .primary

        case .finished:
            return (score ?? 0) > (opponentScore ?? 0) ? .primary : .secondary

        default:
            return .primary
        }
    }
}
