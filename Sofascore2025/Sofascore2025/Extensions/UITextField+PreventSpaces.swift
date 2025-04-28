//
//  UITextField+PreventSpaces.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 26.04.2025..
//

import UIKit

extension UITextField {

    func preventSpaces() {
        self.addTarget(self, action: #selector(checkForSpaces), for: .editingChanged)
    }

    @objc private func checkForSpaces() {
        if let text = self.text {
            self.text = text.replacingOccurrences(of: " ", with: "")
        }
    }
}
