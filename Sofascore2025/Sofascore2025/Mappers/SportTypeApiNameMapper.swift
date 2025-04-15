//
//  SportTypeApiNameMapper.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 15.04.2025..
//

import Foundation

enum SportTypeApiNameMapper {

    static func from(sport: SportType) -> String {
        switch sport {
        case .football:
            return "football"

        case .basketball:
            return "basketball"

        case .americanFootball:
            return "am-football"
        }
    }
}
