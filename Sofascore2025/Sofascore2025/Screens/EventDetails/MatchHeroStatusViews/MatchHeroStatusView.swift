//
//  MatchHeroStatusView.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 09.04.2025..
//

import SnapKit
import SofaAcademic
import UIKit

class MatchHeroStatusView: BaseView {

    private enum Constants {

        static let scoreSpacing: CGFloat = 4
    }

    private let homeTeamScoreLabel = UILabel()
    private let awayTeamScoreLabel = UILabel()
    private let statusLabel = UILabel()
    private let scoreDash = UILabel()

    override func addViews() {
        addSubview(homeTeamScoreLabel)
        addSubview(awayTeamScoreLabel)
        addSubview(scoreDash)
        addSubview(statusLabel)
    }

    override func styleViews() {
        scoreDash.font = .headline
        scoreDash.setText(.scoreDash, withLineHeight: 40)

        homeTeamScoreLabel.font = .headline

        awayTeamScoreLabel.font = .headline

        statusLabel.font = .micro
    }

    override func setupConstraints() {
        homeTeamScoreLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.trailing.equalTo(scoreDash.snp.leading).offset(-Constants.scoreSpacing)
        }

        awayTeamScoreLabel.snp.makeConstraints {
            $0.top.equalTo(homeTeamScoreLabel.snp.top)
            $0.leading.equalTo(scoreDash.snp.trailing).offset(Constants.scoreSpacing)
        }

        scoreDash.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalTo(homeTeamScoreLabel.snp.centerY)
        }

        statusLabel.snp.makeConstraints {
            $0.top.equalTo(scoreDash.snp.bottom)
            $0.centerX.bottom.equalToSuperview()
        }
    }

    func configure(homeScore: String?, homeScoreStyle: UIColor, awayScore: String?, awayScoreStyle: UIColor, statusText: String, statusStyle: UIColor) {
        if let homeScore = homeScore {
            homeTeamScoreLabel.setText(homeScore, withLineHeight: 40)
            homeTeamScoreLabel.textColor = homeScoreStyle
        }

        if let awayScore = awayScore {
            awayTeamScoreLabel.setText(awayScore, withLineHeight: 40)
            awayTeamScoreLabel.textColor = awayScoreStyle
        }

        scoreDash.textColor = statusStyle

        statusLabel.setText(statusText, withLineHeight: 16)
        statusLabel.textColor = statusStyle
    }
}
