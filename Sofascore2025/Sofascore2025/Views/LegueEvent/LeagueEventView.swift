//
//  LeagueEventView.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 11.03.2025..
//

import SnapKit
import SofaAcademic
import UIKit

class LeagueEventView: BaseView {

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

    override func addViews() {
        addSubview(startTimeLabel)
        addSubview(statusLabel)
        addSubview(verticalSeparator)
        addSubview(homeTeamRowView)
        addSubview(awayTeamRowView)
    }

    override func styleViews() {
        startTimeLabel.font = .micro
        startTimeLabel.textColor = .surfaceLv2
        startTimeLabel.textAlignment = .center

        statusLabel.font = .micro
        statusLabel.textColor = .surfaceLv2
        statusLabel.textAlignment = .center

        verticalSeparator.backgroundColor = .surfaceLv4
    }

    override func setupConstraints() {
        startTimeLabel.snp.makeConstraints {
            $0.width.equalTo(Constants.statusLabelWidth)
            $0.leading.equalToSuperview().inset(Padding.matchStatusHorizontal)
            $0.top.equalToSuperview().inset(Padding.vertical)
        }

        statusLabel.snp.makeConstraints {
            $0.width.equalTo(startTimeLabel.snp.width)
            $0.horizontalEdges.equalTo(startTimeLabel)
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
            $0.horizontalEdges.equalTo(homeTeamRowView)
            $0.bottom.equalTo(statusLabel.snp.bottom)
        }
    }
    
    func setupBinding(with event: EventViewModel) {
        startTimeLabel.text = event.startTimestamp
        startTimeLabel.setLineHeight(Constants.lineHeight)
        statusLabel.text = event.matchStatusDescription
        statusLabel.setLineHeight(Constants.lineHeight)

        homeTeamRowView.setupBinding(teamName: event.homeTeamName, teamScore: event.homeScore, teamLogoUrl: event.homeTeamLogoUrl, fetchImage: event.fetchTeamLogo)

        awayTeamRowView.setupBinding(teamName: event.awayTeamName, teamScore: event.awayScore, teamLogoUrl: event.awayTeamLogoUrl, fetchImage: event.fetchTeamLogo)

        switch event.status {
        case .inProgress:
            statusLabel.textColor = .live
            homeTeamRowView.teamScoreLabel.textColor = .live
            awayTeamRowView.teamScoreLabel.textColor = .live

        case .finished:
            if let homeScore = event.homeScore, let awayScore = event.awayScore {
                if homeScore > awayScore {
                    awayTeamRowView.teamNameLabel.textColor = .surfaceLv2
                    awayTeamRowView.teamScoreLabel.textColor = .surfaceLv2
                } else {
                    homeTeamRowView.teamNameLabel.textColor = .surfaceLv2
                    homeTeamRowView.teamScoreLabel.textColor = .surfaceLv2
                }
            }

        default :
            break
        }
    }
}
