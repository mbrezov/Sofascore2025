//
//  LeagueEventTeamRowView.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 12.03.2025..
//

import SnapKit
import SofaAcademic
import UIKit

class LeagueEventTeamRowView: BaseView {

    private enum Padding {

        static let horizontal: CGFloat = 16
        static let vertical: CGFloat = 10
    }

    private enum Constants {

        static let teamImageSize: CGFloat = 16
        static let scoreLabelWidth: CGFloat = 32
        static let teamNameSpacing: CGFloat = 8
        static let lineHeight: CGFloat = 16
    }

    var teamNameLabelTextColor: UIColor? {
        didSet {
            teamNameLabel.textColor = teamNameLabelTextColor
        }
    }

    var teamScoreLabelTextColor: UIColor? {
        didSet {
            teamScoreLabel.textColor = teamScoreLabelTextColor
        }
    }

    private let teamImageView = UIImageView()
    private let teamNameLabel = UILabel()
    private let teamScoreLabel = UILabel()

    override func addViews() {
        addSubview(teamImageView)
        addSubview(teamNameLabel)
        addSubview(teamScoreLabel)
    }

    override func styleViews() {
        teamImageView.contentMode = .scaleAspectFit

        teamNameLabel.font = .body
        teamNameLabel.textColor = .surfaceLv1
        teamNameLabel.numberOfLines = 1

        teamScoreLabel.font = .body
        teamScoreLabel.textColor = .surfaceLv1
        teamScoreLabel.textAlignment = .right
    }

    override func setupConstraints() {
        teamImageView.snp.makeConstraints {
            $0.size.equalTo(Constants.teamImageSize)
            $0.top.bottom.leading.equalToSuperview()
        }

        teamNameLabel.snp.makeConstraints {
            $0.top.equalTo(teamImageView.snp.top)
            $0.leading.equalTo(teamImageView.snp.trailing).offset(Constants.teamNameSpacing)
            $0.trailing.lessThanOrEqualTo(teamScoreLabel.snp.leading).offset(-Padding.horizontal)
        }

        teamScoreLabel.snp.makeConstraints {
            $0.width.equalTo(Constants.scoreLabelWidth)
            $0.top.equalTo(teamNameLabel.snp.top)
            $0.trailing.equalToSuperview()
        }
    }

    func setupUI(teamName: String, teamScore: Int?, teamLogoUrl: URL?) {
        teamNameLabel.text = teamName
        teamNameLabel.setLineHeight(Constants.lineHeight)
        teamScoreLabel.text = teamScore?.description
        teamScoreLabel.setLineHeight(Constants.lineHeight)

        teamImageView.setImageURL(teamLogoUrl)
    }
}
