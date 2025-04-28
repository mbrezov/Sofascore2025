//
//  SettingsViewModel.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 24.04.2025..
//

import Foundation

struct SettingsRow {

    let title: String
    let subtitle: String
}

class SettingsViewModel {

    let rows: [SettingsRow]

    init() {
        let username = UserDefaultsService.readString(forKey: .userAccountName) ?? .settingsUnavailable
        let eventsCountText = String(DatabaseService.readEvents()?.count ?? 0)
        let leaguesCountText = String(DatabaseService.readLeagues()?.count ?? 0)

        self.rows = [
            SettingsRow(title: .settingsRowUsernameTitle, subtitle: username),
            SettingsRow(title: .settingsRowEventsCountTitle, subtitle: eventsCountText),
            SettingsRow(title: .settingsRowLeagueCountTitle, subtitle: leaguesCountText)
        ]
    }

    func logout() {
        AuthService.logout()
    }
}
