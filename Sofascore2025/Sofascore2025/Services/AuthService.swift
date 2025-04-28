//
//  AuthService.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 23.04.2025..
//

import Foundation

enum AuthService {

    static var isAuthed: Bool {
        KeychainService.loadToken(forKey: .authToken) != nil
    }

    static func login(_ response: APIAuthResponse) {
        KeychainService.saveToken(response.token, forKey: .authToken)
        UserDefaultsService.save(data: response.name, forKey: .userAccountName)
        NotificationCenter.default.post(name: .authStatusChanged, object: nil)
    }

    static func logout() {
        KeychainService.deleteToken(forKey: .authToken)
        UserDefaultsService.delete(forKey: .userAccountName)
        DatabaseService.deleteAll()
        NotificationCenter.default.post(name: .authStatusChanged, object: nil)
    }
}
