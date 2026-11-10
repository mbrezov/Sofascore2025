//
//  OutlineButton.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 03.06.2025..
//

import SnapKit
import SofaAcademic
import UIKit

class OutlineButton: UIButton, BaseViewProtocol {

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
        titleLabel?.font = .headline2
        setTitleColor(.surface1, for: .normal)
        layer.cornerRadius = 2
        layer.borderWidth = 2
        layer.borderColor = UIColor.primaryDefault.cgColor
        clipsToBounds = true
        contentEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
    }

    func setupConstraints() {
        self.snp.makeConstraints {
            $0.height.equalTo(Constants.height)
        }
    }
}
