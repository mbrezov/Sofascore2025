//
//  UIView+Constraints.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 10.04.2025..
//

import SnapKit
import UIKit

extension UIView {

    func constrainToTopOfSuperview() {
        self.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
    }
}
