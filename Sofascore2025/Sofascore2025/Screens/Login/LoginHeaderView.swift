//
//  LoginHeaderView.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 26.04.2025..
//

import SnapKit
import SofaAcademic
import UIKit

class LoginHeaderView: BaseView {

    private enum Padding {

        static let horizontal: CGFloat = 16
        static let vertical: CGFloat = 14
    }

    private let logoImageView = UIImageView()

    override func addViews() {
        addSubview(logoImageView)
    }

    override func styleViews() {
        backgroundColor = .primaryDefault

        logoImageView.image = .icSofascoreLogo
        logoImageView.contentMode = .scaleAspectFit
    }

    override func setupConstraints() {
        logoImageView.snp.makeConstraints {
            $0.directionalVerticalEdges.equalTo(safeAreaLayoutGuide).inset(Padding.vertical)
            $0.leading.equalToSuperview().inset(Padding.horizontal)
        }
    }
}
