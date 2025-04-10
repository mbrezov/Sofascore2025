//
//  SportType.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 04.04.2025..
//

import Foundation

enum SportType {

    case football, basketball, americanFootball

    var rawName: String {
        switch self {
        case .football:
            return "football"

        case .basketball:
            return "basketball"

        case .americanFootball:
            return "am-football"
        }
    }
}
