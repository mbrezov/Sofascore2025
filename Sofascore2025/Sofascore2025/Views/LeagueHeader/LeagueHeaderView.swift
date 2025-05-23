//
//  LeagueHeaderView.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 11.03.2025..
//

import SnapKit
import SofaAcademic
import UIKit

class LeagueHeaderView: BaseView {

    private enum Padding {

        static let horizontal: CGFloat = 16
        static let vertical: CGFloat = 12
    }

    private enum Constants {

        static let leagueLogoSize: CGFloat = 32
        static let pointerRightIconSize: CGFloat = 24
        static let leagueLogoSpacing: CGFloat = 32
    }

    private let leagueLogoImageView = UIImageView()
    private let pointerRightIcon = UIImageView()
    private let leagueCountryLabel = UILabel()
    private let leagueNameLabel = UILabel()

    var viewModel: LeagueHeaderViewModel? {
        didSet {
            if let leagueHeaderViewModel = viewModel {
                configure(leagueHeaderViewModel)
            } else {
                cleanup()
            }
        }
    }

    override func addViews() {
        addSubview(leagueLogoImageView)
        addSubview(leagueCountryLabel)
        addSubview(pointerRightIcon)
        addSubview(leagueNameLabel)
    }

    override func styleViews() {
        leagueLogoImageView.contentMode = .scaleAspectFit

        leagueCountryLabel.font = .headline3
        leagueCountryLabel.textColor = .surfaceLv1
        leagueCountryLabel.numberOfLines = 1

        pointerRightIcon.contentMode = .scaleAspectFit
        pointerRightIcon.image = .icPointerRight

        leagueNameLabel.font = .headline3
        leagueNameLabel.textColor = .surfaceLv2
        leagueNameLabel.numberOfLines = 2
    }

    override func setupConstraints() {
        leagueLogoImageView.snp.makeConstraints {
            $0.size.equalTo(Constants.leagueLogoSize)
            $0.leading.equalToSuperview().inset(Padding.horizontal)
            $0.verticalEdges.equalToSuperview().inset(Padding.vertical)
        }

        leagueCountryLabel.snp.makeConstraints {
            $0.leading.equalTo(leagueLogoImageView.snp.trailing).offset(Constants.leagueLogoSpacing)
            $0.centerY.equalTo(leagueLogoImageView)
        }

        pointerRightIcon.snp.makeConstraints {
            $0.size.equalTo(Constants.pointerRightIconSize)
            $0.leading.equalTo(leagueCountryLabel.snp.trailing)
            $0.centerY.equalTo(leagueLogoImageView)
        }

        leagueNameLabel.snp.makeConstraints {
            $0.leading.equalTo(pointerRightIcon.snp.trailing)
            $0.trailing.lessThanOrEqualToSuperview().inset(Padding.horizontal)
            $0.centerY.equalTo(leagueLogoImageView)
        }
    }

    private func configure(_ league: LeagueHeaderViewModel) {
        leagueNameLabel.text = league.name
        leagueCountryLabel.text = league.countryName

        leagueLogoImageView.setImageURL(league.logoURL)
    }

    func cleanup() {
        leagueNameLabel.text = nil
        leagueCountryLabel.text = nil
        leagueLogoImageView.image = nil
    }
}
