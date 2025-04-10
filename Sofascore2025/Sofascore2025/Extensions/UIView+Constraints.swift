//
//  UIView+Constraints.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 10.04.2025..
//

import SnapKit
import UIKit

extension UIView {

    /// Helper method for setting navbar at the top of superview
    func constrainToTopOfSuperview() {
        self.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
    }
}
