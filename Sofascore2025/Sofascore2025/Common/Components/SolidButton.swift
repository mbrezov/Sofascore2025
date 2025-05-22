//
//  SolidButton.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 23.04.2025..
//

import SnapKit
import SofaAcademic
import UIKit

class SolidButton: UIButton, BaseViewProtocol {

    private enum Constants {

        static let height: CGFloat = 40
    }

    init() {
        super.init(frame: .zero)

        styleViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func addViews() {}

    func styleViews() {
        backgroundColor = .primaryDefault
        titleLabel?.font = .headline2
        setTitleColor(.surface1, for: .normal)
        layer.cornerRadius = 2
        clipsToBounds = true
    }

    func setupConstraints() {
        self.snp.makeConstraints {
            $0.height.equalTo(Constants.height)
        }
    }
}
