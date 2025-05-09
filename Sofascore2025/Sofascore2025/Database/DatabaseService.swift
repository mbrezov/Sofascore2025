//
//  DatabaseService.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 25.04.2025..
//

import GRDB

enum DatabaseService {

    static func saveEventsData(_ events: [Event], _ sportType: SportType) -> [Event]? {
        events.forEach { event in
            if let league = event.league {
                writeDBLeague(league)
            }
            writeDBEvent(event, sportType)
        }
        return events
    }

    static func readLeagues() -> [League]? {
        do {
            guard let dbQueue = DatabaseManager.shared.dbQueue else {
                return nil
            }
            let leagues = try dbQueue.read { db in
                try DBLeague.fetchAll(db)
            }
            return leagues.map { LeagueModelMapper.makeLeague(from: $0) }
        } catch {
            print(String.databaseReadError(error))
            return nil
        }
    }

    static func readEvents(for sportType: SportType? = nil) -> [Event]? {
        do {
            guard let dbQueue = DatabaseManager.shared.dbQueue else {
                return nil
            }
            let dbEvents: [DBEvent] = try dbQueue.read { db in
                if let sportType = sportType {
                    return try DBEvent
                        .filter(Column("sportType") == APIClientMapper.sportAPIName(from: sportType))
                        .order(Column("startTimestamp").asc)
                        .fetchAll(db)
                } else {
                    return try DBEvent.fetchAll(db)
                }
            }
            return dbEvents.map { EventModelMapper.makeEvent(from: $0) }
        } catch {
            print(String.databaseReadError(error))
            return nil
        }
    }

    static func deleteAll() {
        do {
            try DatabaseManager.shared.dbQueue?.write { db in
                try DBEvent.deleteAll(db)
                try DBLeague.deleteAll(db)
            }
        } catch {
            print(String.databaseDeleteRowsError(error))
        }
    }

    // MARK: - DB save methods

    private static func writeDBLeague(_ league: League) {
        let dbLeague = LeagueModelMapper.makeDBLeague(from: league)
        do {
            try DatabaseManager.shared.dbQueue?.write { db in
                try? dbLeague.insert(db)
            }
        } catch {
            print(String.databaseInsertRowError(error))
        }
    }

    private static func writeDBEvent(_ event: Event, _ sportType: SportType) {
        let dbEvent = EventModelMapper.makeDBEvent(from: event, sportType: sportType)
        do {
            try DatabaseManager.shared.dbQueue?.write { db in
                try? dbEvent.insert(db)
            }
        } catch {
            print(String.databaseInsertRowError(error))
        }
    }
}
