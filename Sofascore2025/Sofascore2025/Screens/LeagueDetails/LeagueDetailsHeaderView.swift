//
//  LeagueDetailsHeaderView.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 05.06.2025..
//

import UIKit
import SofaAcademic
import SnapKit

class LeagueDetailsHeaderView: BaseView {

    private enum Constants {

        static let iconContainerCornerRadius: CGFloat = 8
        static let iconContainerSize: CGFloat = 56
        static let iconSize: CGFloat = 40
    }

    private enum Padding {

        static let horizontal: CGFloat = 16
        static let vertical: CGFloat = 4
    }

    var nameContainerOpacity: CGFloat = 1.0 {
        didSet {
            nameContainer.alpha = nameContainerOpacity
        }
    }

    var logoImageOpacity: CGFloat = 1.0 {
        didSet {
            logoImageContainerView.alpha = logoImageOpacity
        }
    }

    private let logoImageView = UIImageView()
    private let logoImageContainerView = UIView()
    private let leagueNameLabel = UILabel()
    private let countryNameLabel = UILabel()
    private let nameContainer = UIView()

    override func addViews() {
        addSubview(logoImageContainerView)
        logoImageContainerView.addSubview(logoImageView)
        addSubview(nameContainer)
        nameContainer.addSubview(leagueNameLabel)
        nameContainer.addSubview(countryNameLabel)
    }

    override func styleViews() {
        backgroundColor = .primaryDefault

        logoImageContainerView.backgroundColor = .surface1
        logoImageContainerView.layer.cornerRadius = Constants.iconContainerCornerRadius
        logoImageContainerView.layer.masksToBounds = true

        leagueNameLabel.textColor = .surface1
        leagueNameLabel.font = .headline1

        countryNameLabel.textColor = .surface1
        countryNameLabel.font = .headline3

        logoImageView.contentMode = .scaleAspectFit
    }

    override func setupConstraints() {
        logoImageContainerView.snp.makeConstraints {
            $0.size.equalTo(Constants.iconContainerSize)
            $0.top.equalToSuperview()
            $0.leading.bottom.equalToSuperview().inset(Padding.horizontal)
        }

        logoImageView.snp.makeConstraints {
            $0.size.equalTo(Constants.iconSize)
            $0.center.equalTo(logoImageContainerView)
        }

        nameContainer.snp.makeConstraints {
            $0.centerY.equalTo(logoImageContainerView)
            $0.leading.equalTo(logoImageContainerView.snp.trailing).offset(Padding.horizontal)
            $0.trailing.equalToSuperview().inset(Padding.horizontal)
        }

        leagueNameLabel.snp.makeConstraints {
            $0.leading.top.trailing.equalToSuperview()
        }

        countryNameLabel.snp.makeConstraints {
            $0.top.equalTo(leagueNameLabel.snp.bottom).offset(Padding.vertical)
            $0.leading.bottom.trailing.equalToSuperview()
        }
    }

    func configure(
        _ leagueName: String,
        _ countryName: String?,
        _ logoURL: URL?
    ) {
        logoImageView.setImageURL(logoURL)
        leagueNameLabel.text = leagueName
        countryNameLabel.text = countryName
    }
}
