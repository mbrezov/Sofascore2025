//
//  IncidentsViewModel.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 24.05.2025..
//

import Foundation

class IncidentsViewModel {

    private var incidents: [Incident] = []
    private var sportType: SportType?
    var onIncidentsUpdated: (() -> Void)?
    var isDataFetching: ((Bool) -> Void)?

    init(eventId: Int, sportType: SportType?) {
        getEventIncidents(eventId)
        self.sportType = sportType
    }

    var visibleIncidents: [Incident] {
        incidents.filter { $0.type != "PERIOD_END" }
    }

    func makeIncidentCellViewModel(for incident: Incident) -> IncidentsCellViewModel? {
        let incidentsCellViewModel = IncidentsCellViewModel(
            incident: incident, sportType: sportType
        )
        return incidentsCellViewModel
    }

    private func getEventIncidents(_ id: Int) {
        self.isDataFetching?(true)

        Task {
            do {
                let incidentsModels = try await APIService.fetchEventIncidents(for: id)
                finishEventsReload(with: incidentsModels)
            } catch let error as APIError {
                switch error {
                case .noInternet:
                    print(error.title, error.message)
                    self.finishEventsReload(
                        errorTitle: error.title,
                        errorMessage: error.message
                    )

                default:
                    print(error.title, error.message)
                    self.finishEventsReload(
                        errorTitle: error.title,
                        errorMessage: error.message
                    )
                }
            }
        }
    }

    private func finishEventsReload(
        with incidents: [Incident]? = nil,
        errorTitle: String? = nil,
        errorMessage: String? = nil
    ) {
        DispatchQueue.main.async {
            self.incidents = incidents ?? []
            self.onIncidentsUpdated?()
            self.isDataFetching?(false)
        }
    }
}
