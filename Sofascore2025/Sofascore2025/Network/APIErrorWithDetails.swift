//
//  APIErrorWithDetails.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 28.04.2025..
//

import Foundation

enum APIErrorWithDetails: Error {

    case custom(title: String, message: String, type: APIError)
}
