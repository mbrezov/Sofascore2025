//
//  APIError.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 15.04.2025..
//

import Foundation

enum APIError: Error {

    case invalidURL, noInternet, decodingFailed, unknown(Error)
}
