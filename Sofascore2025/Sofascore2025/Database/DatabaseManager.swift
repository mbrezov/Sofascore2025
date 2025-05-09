//
//  DatabaseManager.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 25.04.2025..
//

import Foundation
import GRDB

final class DatabaseManager {

    static let shared = DatabaseManager()

    lazy var dbQueue: DatabaseQueue? = {
        do {
            let dbURL = try FileManager.default
                .url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                .appendingPathComponent("db-academy.sqlite")

            return try DatabaseQueue(path: dbURL.path)
        } catch {
            print(String.databaseInitializeError(error))
            return nil
        }
    }()

    private init() {
        createTables()
    }

    private func createTables() {
        guard let dbQueue = dbQueue else { return }
        do {
            try dbQueue.write { db in
                try db.create(table: "dbleague", ifNotExists: true) { table in
                    table.column("id", .integer).primaryKey()
                    table.column("name", .text).notNull()
                    table.column("countryId", .integer)
                    table.column("countryName", .text)
                    table.column("logoUrl", .text)
                }

                try db.create(table: "dbevent", ifNotExists: true) { table in
                    table.column("id", .integer).primaryKey()
                    table.column("sportType", .text)
                    table.column("homeTeamId", .integer)
                    table.column("homeTeamName", .text)
                    table.column("homeTeamLogoUrl", .text)
                    table.column("awayTeamId", .integer)
                    table.column("awayTeamName", .text)
                    table.column("awayTeamLogoUrl", .text)
                    table.column("startTimestamp", .integer)
                    table.column("leagueId", .integer)
                    table.column("leagueName", .text)
                    table.column("leagueCountryId", .integer)
                    table.column("leagueCountryName", .text)
                    table.column("leagueLogoUrl", .text)
                    table.column("status", .text)
                    table.column("homeScore", .integer)
                    table.column("awayScore", .integer)
                }
            }
        } catch {
            print(String.databaseTablesCreatingError(error))
        }
    }
}
