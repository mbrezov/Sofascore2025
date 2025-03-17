//
//  StringFormatterService.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 15.03.2025..
//

import Foundation

class StringFormatterService {

    static func stringToURL(_ string: String?) -> URL? {
        guard let string = string else { return nil }

        return URL(string: string)
    }
}
