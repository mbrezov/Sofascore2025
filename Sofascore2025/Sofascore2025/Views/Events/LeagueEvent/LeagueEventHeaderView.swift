//
//  LeagueEventHeaderView.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 19.03.2025..
//

import UIKit
import SnapKit

class LeagueEventHeaderView: UICollectionReusableView {

    static let reuseIdentifier = "LeagueEventHeaderView"

    static var height: CGFloat {
        (2 * Padding.vertical) + Constants.leagueLogoSize
    }

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

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .surface1

        addViews()
        styleViews()
        setupConstraints()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func addViews() {
        addSubview(leagueLogoImageView)
        addSubview(leagueCountryLabel)
        addSubview(pointerRightIcon)
        addSubview(leagueNameLabel)
    }

    func styleViews() {
        leagueLogoImageView.contentMode = .scaleAspectFit

        leagueCountryLabel.font = .headline
        leagueCountryLabel.textColor = .surfaceLv1
        leagueCountryLabel.numberOfLines = 1

        pointerRightIcon.contentMode = .scaleAspectFit
        pointerRightIcon.image = .pointerRightIcon

        leagueNameLabel.font = .headline
        leagueNameLabel.textColor = .surfaceLv2
        leagueNameLabel.numberOfLines = 2
    }

    func setupConstraints() {
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

    func bind(_ league: LeagueViewModel) {
        leagueNameLabel.text = league.name
        leagueCountryLabel.text = league.country?.name

        leagueLogoImageView.setImageURL(league.logoURL)
    }
}
