//
//  UIColor+Map.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 25.03.2025..
//

import UIKit

extension UIColor {

    static func mapMatchStatus(from status: MatchStatusColor) -> UIColor {
        switch status {
        case .live:
            return .live

        case .surfaceLv1:
            return .surfaceLv1

        case .surfaceLv2:
            return .surfaceLv2
        }
    }
}
