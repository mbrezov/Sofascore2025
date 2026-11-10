//
//  IncidentModelMapper.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 23.05.2025..
//

import Foundation

enum IncidentModelMapper {

    static func makeDBIncident(from apiIncident: APIIncident) -> DBIncident {
        DBIncident(type: apiIncident.type,
                   minute: apiIncident.minute,
                   isHomeTeam: apiIncident.isHomeTeam,
                   extraMinute: apiIncident.extraMinute,
                   player: apiIncident.player,
                   scoreDiff: apiIncident.scoreDiff,
                   score: apiIncident.score,
                   description: apiIncident.description
        )
    }

    static func makeIncident(from dbIncident: DBIncident) -> Incident {
        Incident(
            type: dbIncident.type,
            minute: dbIncident.minute,
            isHomeTeam: dbIncident.isHomeTeam,
            extraMinute: dbIncident.extraMinute,
            player: dbIncident.player,
            scoreDiff: dbIncident.scoreDiff,
            score: dbIncident.score,
            description: dbIncident.description
        )
    }

    static func makeIncident(from apiIncident: APIIncident) -> Incident {
        Incident(type: apiIncident.type,
                   minute: apiIncident.minute,
                   isHomeTeam: apiIncident.isHomeTeam,
                   extraMinute: apiIncident.extraMinute,
                   player: apiIncident.player,
                   scoreDiff: apiIncident.scoreDiff,
                   score: apiIncident.score,
                   description: apiIncident.description
        )
    }
}
