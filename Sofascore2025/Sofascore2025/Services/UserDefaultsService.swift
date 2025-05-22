//
//  UserDefaultsService.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 24.04.2025..
//

import Foundation

enum UserDefaultsService {

    private static let userDefaults = UserDefaults.standard

    static func save<T>(data: T, forKey key: UserDefaultsKeys) {
        userDefaults.set(data, forKey: key.rawValue)
    }

    static func readString(forKey key: UserDefaultsKeys) -> String? {
        userDefaults.string(forKey: key.rawValue)
    }

    static func delete(forKey key: UserDefaultsKeys) {
        userDefaults.removeObject(forKey: key.rawValue)
    }
}
