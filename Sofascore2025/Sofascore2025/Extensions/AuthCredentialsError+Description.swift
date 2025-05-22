//
//  AuthCredentialsError+Description.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 26.04.2025..
//

import Foundation

extension AuthCredentialsError {

    var title: String {
        switch self {
        case .emptyCredentials:
            return .emptyCredentialsTitle

        case .emptyUsername:
            return .emptyUsernameTitle

        case .emptyPassword:
            return .emptyPasswordTitle
        }
    }

    var message: String {
        switch self {
        case .emptyCredentials:
            return .emptyCredentialsMessage

        case .emptyUsername:
            return .emptyUsernameMessage

        case .emptyPassword:
            return .emptyPasswordMessage
        }
    }
}
