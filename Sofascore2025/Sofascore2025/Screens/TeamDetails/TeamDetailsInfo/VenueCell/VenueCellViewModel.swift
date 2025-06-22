//
//  VenueCellViewModel.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 20.06.2025..
//

import Foundation

class VenueCellViewModel {

    let venueName: String

    init(venue: TeamVenue) {
        self.venueName = venue.name
    }
}
