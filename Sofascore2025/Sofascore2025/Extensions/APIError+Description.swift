//
//  APIError+Description.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 15.04.2025..
//

import Foundation

extension APIError {

    var title: String {
        switch self {
        case .invalidURL:
            return .URLErrorTitle

        case .noInternet:
            return .networkErrorTitle

        case .decodingFailed:
            return .decodingErrorTitle

        case .unknown:
            return .errorTitle
        }
    }

    var message: String {
        switch self {
        case .invalidURL:
            return .URLErrorMessage

        case .noInternet:
            return .networkErrorMessage

        case .decodingFailed:
            return .decodingErrorMessage

        case .unknown(let error):
            return "\(error.localizedDescription)"
        }
    }
}
