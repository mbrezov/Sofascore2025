//
//  SettingsViewModel.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 24.04.2025..
//

import Foundation

struct SettingsRowInfo {

    let title: String
    let subtitle: String
}

class SettingsViewModel {

    let rows: [SettingsRowInfo]

    init() {
        let username = UserDefaultsService.readString(forKey: .userAccountName) ?? .settingsUnavailable
        let eventsCountText = String(DatabaseService.readEvents()?.count ?? 0)
        let leaguesCountText = String(DatabaseService.readLeagues()?.count ?? 0)

        self.rows = [
            SettingsRowInfo(title: .settingsRowUsernameTitle, subtitle: username),
            SettingsRowInfo(title: .settingsRowEventsCountTitle, subtitle: eventsCountText),
            SettingsRowInfo(title: .settingsRowLeagueCountTitle, subtitle: leaguesCountText)
        ]
    }

    func logout() {
        AuthService.logout()
    }
}
