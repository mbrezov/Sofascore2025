//
//  KeychainService.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 24.04.2025..
//

import Foundation
import KeychainAccess

enum KeychainService {

    private static let keychain = Keychain(service: "com.sofa.academy")

    static func saveToken(_ token: String, forKey key: KeychainKeys) {
        keychain[key.rawValue] = token
    }

    static func loadToken(forKey key: KeychainKeys) -> String? {
        keychain[key.rawValue]
    }

    static func deleteToken(forKey key: KeychainKeys) {
        do {
            try keychain.remove(key.rawValue)
        } catch let error {
            print(String.keychainRemoveError(error))
        }
    }
}
