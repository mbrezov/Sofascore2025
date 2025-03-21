//
//  LeagueEventCell.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 19.03.2025..
//

import UIKit
import SnapKit

class LeagueEventCell: UICollectionViewCell {

    static let reuseIdentifier = "LeagueEventCollectionViewCell"

    static var height: CGFloat {
        (2 * (Padding.vertical + LeagueEventTeamRowView.height)) + Constants.verticalSpacing
    }

    private enum Padding {

        static let horizontal: CGFloat = 16
        static let vertical: CGFloat = 10
        static let matchStatusHorizontal: CGFloat = 4
        static let separatorVertical: CGFloat = 8
    }

    private enum Constants {

        static let separatorWidth: CGFloat = 1
        static let statusLabelWidth: CGFloat = 56
        static let verticalSpacing: CGFloat = 4
        static let lineHeight: CGFloat = 16
    }

    private let startTimeLabel = UILabel()
    private let statusLabel = UILabel()
    private let verticalSeparator = UIView()
    private let homeTeamRowView = LeagueEventTeamRowView()
    private let awayTeamRowView = LeagueEventTeamRowView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        addViews()
        styleViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func addViews() {
        contentView.addSubview(startTimeLabel)
        contentView.addSubview(statusLabel)
        contentView.addSubview(verticalSeparator)
        contentView.addSubview(homeTeamRowView)
        contentView.addSubview(awayTeamRowView)
    }

    func styleViews() {
        startTimeLabel.font = .micro
        startTimeLabel.textColor = .surfaceLv2
        startTimeLabel.textAlignment = .center

        statusLabel.font = .micro
        statusLabel.textColor = .surfaceLv2
        statusLabel.textAlignment = .center

        verticalSeparator.backgroundColor = .surfaceLv4
    }

    func setupConstraints() {
        startTimeLabel.snp.makeConstraints {
            $0.width.equalTo(Constants.statusLabelWidth)
            $0.leading.equalToSuperview().inset(Padding.matchStatusHorizontal)
            $0.top.equalToSuperview().inset(Padding.vertical)
        }

        statusLabel.snp.makeConstraints {
            $0.width.equalTo(startTimeLabel.snp.width)
            $0.leading.trailing.equalTo(startTimeLabel)
            $0.top.equalTo(startTimeLabel.snp.bottom).offset(Constants.verticalSpacing)
            $0.bottom.equalToSuperview().inset(Padding.vertical)
        }

        verticalSeparator.snp.makeConstraints {
            $0.width.equalTo(Constants.separatorWidth)
            $0.leading.equalTo(startTimeLabel.snp.trailing).offset(Padding.matchStatusHorizontal)
            $0.verticalEdges.equalToSuperview().inset(Padding.separatorVertical)
        }

        homeTeamRowView.snp.makeConstraints {
            $0.top.equalTo(startTimeLabel.snp.top)
            $0.leading.equalTo(verticalSeparator.snp.trailing).offset(Padding.horizontal)
            $0.trailing.equalToSuperview().inset(Padding.horizontal)
        }

        awayTeamRowView.snp.makeConstraints {
            $0.top.equalTo(homeTeamRowView.snp.bottom).offset(Constants.verticalSpacing)
            $0.leading.trailing.equalTo(homeTeamRowView)
            $0.bottom.equalTo(statusLabel.snp.bottom)
        }
    }

    func bind(_ event: EventViewModel) {
        startTimeLabel.text = event.startTimestamp
        startTimeLabel.setLineHeight(Constants.lineHeight)
        statusLabel.text = event.matchStatusDescription
        statusLabel.setLineHeight(Constants.lineHeight)

        homeTeamRowView.setupUI(teamName: event.homeTeamName, teamScore: event.homeScore, teamLogoURL: event.homeTeamLogoURL)

        awayTeamRowView.setupUI(teamName: event.awayTeamName, teamScore: event.awayScore, teamLogoURL: event.awayTeamLogoURL)

        switch event.status {
        case .inProgress:
            statusLabel.textColor = .live
            homeTeamRowView.teamScoreLabelTextColor = .live
            awayTeamRowView.teamScoreLabelTextColor = .live

        case .finished:
            if let homeScore = event.homeScore, let awayScore = event.awayScore {
                if homeScore > awayScore {
                    awayTeamRowView.teamNameLabelTextColor = .surfaceLv2
                    awayTeamRowView.teamScoreLabelTextColor = .surfaceLv2
                } else {
                    homeTeamRowView.teamNameLabelTextColor = .surfaceLv2
                    homeTeamRowView.teamScoreLabelTextColor = .surfaceLv2
                }
            }

        default :
            break
        }
    }
}
