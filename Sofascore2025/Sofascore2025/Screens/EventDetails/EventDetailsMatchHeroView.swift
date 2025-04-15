//
//  EventDetailsMatchHeroView.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 08.04.2025..
//

import SnapKit
import SofaAcademic
import UIKit

class EventDetailsMatchHeroView: BaseView {

    private enum Constants {

        static let teamImageSize: CGFloat = 40
        static let teamImageSpacing: CGFloat = 8
    }

    private enum Padding {

        static let inset: CGFloat = 16
        static let teamImageHorizontal: CGFloat = 28
        static let statusContainerTop: CGFloat = 16
    }

    private let homeTeamImageView = UIImageView()
    private let homeTeamNameLabel = UILabel()
    private let homeTeamContrainer = UIView()
    private let awayTeamImageView = UIImageView()
    private let awayTeamNameLabel = UILabel()
    private let awayTeamContrainer = UIView()
    private let centerHorizontalStackView = UIStackView()

    private lazy var statusView = MatchHeroStatusView()
    private lazy var statusUpcomingView = MatchHeroStatusUpcomingView()

    override func addViews() {
        addSubview(homeTeamContrainer)
        homeTeamContrainer.addSubview(homeTeamImageView)
        homeTeamContrainer.addSubview(homeTeamNameLabel)
        addSubview(awayTeamContrainer)
        awayTeamContrainer.addSubview(awayTeamImageView)
        awayTeamContrainer.addSubview(awayTeamNameLabel)
        addSubview(centerHorizontalStackView)
        centerHorizontalStackView.addArrangedSubview(statusUpcomingView)
        centerHorizontalStackView.addArrangedSubview(statusView)
    }

    override func styleViews() {
        backgroundColor = .surface1

        homeTeamImageView.contentMode = .scaleAspectFit

        homeTeamNameLabel.numberOfLines = 0
        homeTeamNameLabel.textAlignment = .center
        homeTeamNameLabel.font = .assistive

        awayTeamImageView.contentMode = .scaleAspectFit

        awayTeamNameLabel.numberOfLines = 0
        awayTeamNameLabel.textAlignment = .center
        awayTeamNameLabel.font = .assistive
    }

    override func setupConstraints() {
        homeTeamContrainer.snp.makeConstraints {
            $0.directionalVerticalEdges.leading.equalToSuperview().inset(Padding.inset)
        }

        homeTeamImageView.snp.makeConstraints {
            $0.size.equalTo(Constants.teamImageSize)
            $0.top.equalToSuperview()
            $0.directionalHorizontalEdges.equalToSuperview().inset(Padding.teamImageHorizontal)
        }

        homeTeamNameLabel.snp.makeConstraints {
            $0.top.equalTo(homeTeamImageView.snp.bottom).offset(Constants.teamImageSpacing)
            $0.directionalHorizontalEdges.bottom.equalToSuperview()
        }

        awayTeamContrainer.snp.makeConstraints {
            $0.directionalVerticalEdges.trailing.equalToSuperview().inset(Padding.inset)
        }

        awayTeamImageView.snp.makeConstraints {
            $0.size.equalTo(Constants.teamImageSize)
            $0.top.equalToSuperview()
            $0.directionalHorizontalEdges.equalToSuperview().inset(Padding.teamImageHorizontal)
        }

        awayTeamNameLabel.snp.makeConstraints {
            $0.top.equalTo(homeTeamImageView.snp.bottom).offset(Constants.teamImageSpacing)
            $0.directionalHorizontalEdges.bottom.equalToSuperview()
        }

        centerHorizontalStackView.snp.makeConstraints {
            $0.leading.equalTo(homeTeamContrainer.snp.trailing)
            $0.trailing.equalTo(awayTeamContrainer.snp.leading)
            $0.top.equalToSuperview().inset(Padding.statusContainerTop)
        }
    }

    func configure(homeTeamInfo: EventTeamInfo, awayTeamInfo: EventTeamInfo, isStarted: Bool, dateText: String, startTimeText: String, statusText: String, statusColor: UIColor) {
        homeTeamImageView.setImageURL(homeTeamInfo.logoURL)
        awayTeamImageView.setImageURL(awayTeamInfo.logoURL)

        homeTeamNameLabel.setText(homeTeamInfo.name, withLineHeight: 16)
        awayTeamNameLabel.setText(awayTeamInfo.name, withLineHeight: 16)

        if isStarted {
            statusView.isHidden = true
            statusUpcomingView.configure(
                dateText: dateText,
                timeText: startTimeText
            )
        } else {
            statusUpcomingView.isHidden = true
            statusView.configure(
                homeScore: homeTeamInfo.score?.description,
                homeScoreColor: homeTeamInfo.scoreColor.uiColor,
                awayScore: awayTeamInfo.score?.description,
                awayScoreColor: awayTeamInfo.scoreColor.uiColor,
                statusText: statusText,
                statusColor: statusColor
            )
        }
    }
}
