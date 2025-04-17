//
//  String+URL.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 17.03.2025..
//

import Foundation

extension String {

    var url: URL? {
        return URL(string: self)
    }
}
