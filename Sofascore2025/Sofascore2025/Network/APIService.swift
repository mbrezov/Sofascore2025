//
//  APIService.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 28.04.2025..
//

import Foundation

enum APIService {

    // MARK: - Events fetching

    static func fetchEvents(for sportType: SportType) async throws -> [Event]? {
        let apiEvents: [APIEvent] = try await APIClient.getEvents(for: sportType)
        let events: [Event] = apiEvents.map { EventModelMapper.makeEvent(from: $0) }
        return DatabaseService.saveEventsData(events, sportType)
    }

    static func fetchEvent(for id: Int) async throws -> Event? {
        let apiEvent: APIEvent = try await APIClient.getEvent(for: id)
        let event: Event = EventModelMapper.makeEvent(from: apiEvent)
        return event
    }

    static func fetchEventIncidents(for id: Int) async throws -> [Incident]? {
        let apiEventIncidents: [APIIncident] = try await APIClient.getEventIncidents(for: id)
        let eventIncidents: [Incident] = apiEventIncidents.map { IncidentModelMapper.makeIncident(from: $0) }
        return eventIncidents
    }

    // MARK: - League fetching

    static func fetchLeagueMatches(for id: Int) async throws -> [Event]? {
        let apiEvent: [APIEvent] = try await APIClient.getLeagueMathes(for: id)
        let leagueMatches: [Event] = apiEvent.map { EventModelMapper.makeEvent(from: $0) }
        return leagueMatches
    }

    static func fetchLeagueStandings(for id: Int) async throws -> [Standings]? {
        let apiStandings: [APIStandings] = try await APIClient.getLeagueStandings(for: id)
        let leagueStandings = apiStandings.map { apiStanding in
            StandingsModelMapper.makeStandings(from: apiStanding)
        }
        return leagueStandings
    }

    // MARK: - Team fetching

    static func fetchTeamDetails(for id: Int) async throws -> TeamInfo? {
        let apiTeam: APITeamInfo = try await APIClient.getTeamDetails(for: id)
        let teamDetails = TeamInfoModelMapper.makeTeamInfo(from: apiTeam)
        return teamDetails
    }

    static func fetchTeamPlayers(for id: Int) async throws -> [Player]? {
        let apiTeamPlayers: [APIPlayer] = try await APIClient.getTeamPlayers(for: id)
        let teamPlayers = apiTeamPlayers.map { teamPlayers in
            PlayerModelMapper.makePlayer(from: teamPlayers)
        }
        return teamPlayers
    }

    static func fetchTeamTournaments(for id: Int) async throws -> [League]? {
        let apiTournaments: [APILeague] = try await APIClient.getTeamTournaments(for: id)
        let tournaments = apiTournaments.map { tournaments in
            LeagueModelMapper.makeLeague(from: tournaments)
        }
        return tournaments
    }

    // MARK: - Login call

    static func login(username: String?, password: String?) async throws -> APIAuthResponse? {
        let validatedUsername: String
        let validatedPassword: String

        (validatedUsername, validatedPassword) = try AuthCredentialsValidationService.validate(username, password)

        let response = try await APIClient.login(username: validatedUsername, password: validatedPassword)
        return response
    }
}
