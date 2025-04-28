//
//  SolidButton.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 23.04.2025..
//

import SnapKit
import UIKit

class SolidButton: UIButton {

    private enum Constants {

        static let height: CGFloat = 40
    }

    init() {
        super.init(frame: .zero)

        styleUI()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func styleUI() {
        backgroundColor = .primaryDefault
        titleLabel?.font = .headline2
        setTitleColor(.surface1, for: .normal)
        layer.cornerRadius = 2
        clipsToBounds = true
    }

    private func setupConstraints() {
        self.snp.makeConstraints {
            $0.height.equalTo(Constants.height)
        }
    }
}
