//
//  EventTeamRowView.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 12.03.2025..
//

import SnapKit
import SofaAcademic
import UIKit

class EventTeamRowView: BaseView {

    private enum Padding {

        static let horizontal: CGFloat = 16
    }

    private enum Constants {

        static let teamImageSize: CGFloat = 16
        static let scoreLabelWidth: CGFloat = 32
        static let teamNameSpacing: CGFloat = 8
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
            $0.directionalVerticalEdges.leading.equalToSuperview()
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

    func configure(with teamInfo: EventTeamInfo) {
        teamNameLabel.setText(teamInfo.name, withLineHeight: 16)

        if let teamScore = teamInfo.score?.description {
            teamScoreLabel.setText(teamScore, withLineHeight: 16)
        }

        teamNameLabel.textColor = teamInfo.color.uiColor
        teamScoreLabel.textColor = teamInfo.scoreColor.uiColor

        teamImageView.setImageURL(teamInfo.logoURL)
    }

    func cleanup() {
        teamNameLabel.text = nil
        teamImageView.image = nil
        teamScoreLabel.text = nil
    }
}
