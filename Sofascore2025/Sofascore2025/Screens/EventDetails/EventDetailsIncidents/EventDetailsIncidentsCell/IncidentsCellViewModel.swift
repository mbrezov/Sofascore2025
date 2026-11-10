//
//  IncidentsCellViewModel.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 24.05.2025..
//

import Foundation

class IncidentsCellViewModel {

    let type: IncidentType
    let minuteText: String
    let isHomeTeam: Bool?
    let player: String?
    let score: String?
    let description: String?
    let sportType: SportType?

    init(incident: Incident, sportType: SportType?) {
        self.type = APIClientMapper.incidentType(from: incident.type)
        self.minuteText = String(incident.minute) + "′"
        self.isHomeTeam = incident.isHomeTeam
        self.player = incident.player
        self.score = incident.score
        self.description = incident.description
        self.sportType = sportType
    }
}
