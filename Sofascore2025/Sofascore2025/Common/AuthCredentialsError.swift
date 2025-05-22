//
//  AuthCredentialsError.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 26.04.2025..
//

import Foundation

enum AuthCredentialsError: Error {

    case emptyCredentials, emptyUsername, emptyPassword
}
