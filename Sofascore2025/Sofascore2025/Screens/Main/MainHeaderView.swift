//
//  MainHeaderView.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 08.04.2025..
//

import SnapKit
import SofaAcademic
import UIKit

protocol MainHeaderViewDelegate: AnyObject {

    func mainHeaderViewDidPressSettings(_ mainHeaderView: MainHeaderView)
}

class MainHeaderView: BaseView {

    private enum Constants {

        static let iconSize: CGFloat = 48
    }

    private enum Padding {

        static let logoLeft: CGFloat = 16
        static let settingsIconRight: CGFloat = 4
    }

    weak var delegate: MainHeaderViewDelegate?

    private let logoImageView = UIImageView()
    private let tournamentButton = UIButton()
    private let settingsButton = UIButton()

    override func addViews() {
        addSubview(logoImageView)
        addSubview(tournamentButton)
        addSubview(settingsButton)
    }

    override func styleViews() {
        backgroundColor = .primaryDefault

        logoImageView.image = .icSofascoreLogo
        logoImageView.contentMode = .scaleAspectFit

        tournamentButton.tintColor = .surface1
        tournamentButton.setImage(.icTrophy, for: .normal)

        settingsButton.tintColor = .surface1
        settingsButton.setImage(.icSettings, for: .normal)
        settingsButton.addTarget(self, action: #selector(opetSettingsTappeed), for: .touchUpInside)
    }

    override func setupConstraints() {
        logoImageView.snp.makeConstraints {
            $0.centerY.equalTo(tournamentButton.snp.centerY)
            $0.leading.equalToSuperview().inset(Padding.logoLeft)
        }

        tournamentButton.snp.makeConstraints {
            $0.directionalVerticalEdges.equalTo(safeAreaLayoutGuide)
            $0.trailing.equalTo(settingsButton.snp.leading)
            $0.size.equalTo(Constants.iconSize)
        }

        settingsButton.snp.makeConstraints {
            $0.directionalVerticalEdges.equalTo(tournamentButton)
            $0.trailing.equalToSuperview().inset(Padding.settingsIconRight)
            $0.size.equalTo(Constants.iconSize)
        }
    }

    @objc private func opetSettingsTappeed() {
        delegate?.mainHeaderViewDidPressSettings(self)
    }
}
