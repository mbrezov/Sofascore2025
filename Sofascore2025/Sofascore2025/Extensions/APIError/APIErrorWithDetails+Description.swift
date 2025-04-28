//
//  APIErrorWithDetails+Description.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 28.04.2025..
//

import Foundation

extension APIErrorWithDetails {

    var title: String {
        switch self {
        case .custom(let title, _, _): return title
        }
    }

    var message: String {
        switch self {
        case .custom(_, let message, _): return message
        }
    }

    var type: APIError {
        switch self {
        case .custom(_, _, let type): return type
        }
    }
}
