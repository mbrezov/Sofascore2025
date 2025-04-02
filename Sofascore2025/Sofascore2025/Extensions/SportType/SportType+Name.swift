//
//  SportType+Name.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 01.04.2025..
//

import UIKit

extension SportType {

    var name: String {
        switch self {
        case .football:
            return .football

        case .basketball:
            return .basketball

        case .americanFootball:
            return .americanFootball
        }
    }
}
