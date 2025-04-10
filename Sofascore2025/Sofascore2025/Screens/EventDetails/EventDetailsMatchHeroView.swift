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

    private lazy var statusView = MatchHeroStatusView()
    private lazy var statusUpcomingView = MatchHeroStatusUpcomingView()

    var viewModel: EventDetailsViewModel? {
        didSet {
            if let event = viewModel {
                configure(event)
            }
        }
    }

    override func addViews() {
        addSubview(homeTeamContrainer)
        homeTeamContrainer.addSubview(homeTeamImageView)
        homeTeamContrainer.addSubview(homeTeamNameLabel)
        addSubview(awayTeamContrainer)
        awayTeamContrainer.addSubview(awayTeamImageView)
        awayTeamContrainer.addSubview(awayTeamNameLabel)
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
            $0.top.equalTo(safeAreaLayoutGuide).inset(Padding.inset)
            $0.bottom.leading.equalToSuperview().inset(Padding.inset)
        }

        homeTeamImageView.snp.makeConstraints {
            $0.size.equalTo(Constants.teamImageSize)
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(Padding.teamImageHorizontal)
        }

        homeTeamNameLabel.snp.makeConstraints {
            $0.top.equalTo(homeTeamImageView.snp.bottom).offset(Constants.teamImageSpacing)
            $0.leading.trailing.bottom.equalToSuperview()
        }

        awayTeamContrainer.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).inset(Padding.inset)
            $0.bottom.trailing.equalToSuperview().inset(Padding.inset)
        }

        awayTeamImageView.snp.makeConstraints {
            $0.size.equalTo(Constants.teamImageSize)
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(Padding.teamImageHorizontal)
        }

        awayTeamNameLabel.snp.makeConstraints {
            $0.top.equalTo(homeTeamImageView.snp.bottom).offset(Constants.teamImageSpacing)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }

    private func configure(_ eventDetails: EventDetailsViewModel) {
        let homeTeamInfo = eventDetails.homeTeamInfo
        let awayTeamInfo = eventDetails.awayTeamInfo

        homeTeamImageView.setImageURL(homeTeamInfo.logoURL)
        awayTeamImageView.setImageURL(awayTeamInfo.logoURL)

        homeTeamNameLabel.setText(awayTeamInfo.name, withLineHeight: 16)
        awayTeamNameLabel.setText(awayTeamInfo.name, withLineHeight: 16)

        if eventDetails.isNotStarted {
            statusUpcomingView.configure(
                dateText: eventDetails.dateText,
                startTimeText: eventDetails.startTimeText
            )

            addStatusContainer(with: statusUpcomingView)
        } else {
            statusView.configure(
                homeScore: homeTeamInfo.score?.description,
                homeScoreStyle: homeTeamInfo.scoreStyle.color,
                awayScore: awayTeamInfo.score?.description,
                awayScoreStyle: awayTeamInfo.scoreStyle.color,
                statusText: eventDetails.statusInfo.description,
                statusStyle: eventDetails.statusInfo.style.color
            )

            addStatusContainer(with: statusView)
        }
    }

    // MARK: - status container setup

    private func addStatusContainer(with container: UIView) {
        addSubview(container)

        container.snp.makeConstraints {
            $0.leading.equalTo(homeTeamContrainer.snp.trailing)
            $0.trailing.equalTo(awayTeamContrainer.snp.leading)
            $0.top.equalTo(safeAreaInsets).inset(Padding.statusContainerTop)
        }
    }
}
