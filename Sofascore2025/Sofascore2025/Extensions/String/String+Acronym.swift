//
//  String+Acronym.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 09.04.2025..
//

import UIKit

extension String {

    private func getAcronym(for string: String) -> String {
        let words = string.components(separatedBy: .whitespacesAndNewlines).filter { !$0.isEmpty }

        guard words.count > 1 else { return string }

        return words.map { String($0.prefix(1)) }.joined()
    }

    var acronym: String {
        return getAcronym(for: self)
    }
}
