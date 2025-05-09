//
//  APIAuthResponse.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 24.04.2025..
//

import Foundation

public struct APIAuthResponse: Decodable {

    public let name: String
    public let token: String
}
