//
//  AuthCredentialsValidatorService.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 26.04.2025..
//

import Foundation

enum AuthCredentialsValidatorService {

    static func validate(
        _ username: String?,
        _ password: String?
    ) throws -> (
        username: String,
        password: String
    ) {
        if (username?.isEmpty ?? true) && (password?.isEmpty ?? true) {
            throw AuthCredentialsError.emptyCredentials
        }

        guard let username = username, !username.isEmpty else {
            throw AuthCredentialsError.emptyUsername
        }

        guard let password = password, !password.isEmpty else {
            throw AuthCredentialsError.emptyPassword
        }

        return (username, password)
    }
}
