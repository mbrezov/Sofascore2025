//
//  EventStatusColor+UIColor.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 01.04.2025..
//

import UIKit

extension EventStatusColor {

    var uiColor: UIColor {
        switch self {
        case .live:
            return .live

        case .primary:
            return .surfaceLv1

        case .secondary:
            return .surfaceLv2
        }
    }
}
