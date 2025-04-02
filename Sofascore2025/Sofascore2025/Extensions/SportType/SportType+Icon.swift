//
//  SportType+Icon.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 01.04.2025..
//

import UIKit

extension SportType {

    var icon: UIImage {
        switch self {
        case .football:
            return .icFootball

        case .basketball:
            return .icBasketball

        case .americanFootball:
            return .icAmericanFootball
        }
    }
}
