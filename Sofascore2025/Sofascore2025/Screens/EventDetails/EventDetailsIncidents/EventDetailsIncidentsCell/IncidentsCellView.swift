//
//  IncidentsCellView.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 24.05.2025..
//

import SofaAcademic
import SnapKit
import UIKit

class IncidentsCellView: BaseView {

    private enum Padding {

        static let vertical: CGFloat = 8
        static let horizontal: CGFloat = 8
        static let separatorVertical: CGFloat = 8
        static let iconHorizontal: CGFloat = 16
    }

    private enum Constants {

        static let separatorHeight: CGFloat = 1
        static let horizontalSeparatorWidth: CGFloat = 24
        static let verticalSeparatorWidth: CGFloat = 1
        static let statusIconSize: CGFloat = 20
        static let scoreWidth: CGFloat = 84
    }

    private enum Alignment {

        case home, away
    }

    private let statusContainer = UIView()
    private let statusIconView = UIImageView()
    private let statusTimeTextLabel = UILabel()
    private let playerContainer = UIView()
    private let playerNameLabel = UILabel()
    private let incidentDescriptionLabel = UILabel()
    private let scoreTextLabel = UILabel()
    private let verticalSeparator = UIView()
    private let horizontalSeparator = UIView()

    private var type: IncidentType?
    private var minuteText: String?
    private var isHomeTeam: Bool?
    private var player: String?
    private var score: String?
    private var incidentDescription: String?
    private var sportType: SportType?

    override func addViews() {
        addSubview(statusContainer)
        addSubview(playerContainer)
        addSubview(scoreTextLabel)
        addSubview(verticalSeparator)
    }

    override func styleViews() {
        backgroundColor = .surface1

        statusTimeTextLabel.font = .micro
        statusTimeTextLabel.textColor = .surfaceLv2

        playerNameLabel.font = .body
        playerNameLabel.textColor = .surfaceLv1

        incidentDescriptionLabel.font = .micro
        incidentDescriptionLabel.textColor = .surfaceLv2

        scoreTextLabel.font = .headline1
        scoreTextLabel.textColor = .surfaceLv1
        scoreTextLabel.textAlignment = .center

        statusIconView.contentMode = .scaleAspectFit
        verticalSeparator.backgroundColor = .surfaceLv4
        horizontalSeparator.backgroundColor = .surfaceLv4
    }

    func configure(
        _ type: IncidentType,
        _ minuteText: String,
        _ isHomeTeam: Bool?,
        _ player: String?,
        _ score: String?,
        _ description: String?,
        _ sportType: SportType?
    ) {
        self.type = type
        self.minuteText = minuteText
        self.isHomeTeam = isHomeTeam
        self.player = player
        self.score = score
        self.incidentDescription = description
        self.sportType = sportType

        configureStatusIcon()
        setupStatusContainer()
        setupPlayerContainer()

        if sportType == .basketball {
            makeBasketballConstraints()
        } else if isHomeTeam == true {
            makeHomeConstraints()
        } else {
            makeAwayConstraints()
        }
    }

    private func configureStatusIcon() {
        switch sportType {
        case .americanFootball:
            statusIconView.image = .icAmBall

        case .basketball:
            statusIconView.image = .icBasketballPoint

        default:
            statusIconView.image = (type == .goal) ? .icFootball.withTintColor(.success) : .icYellowCard
        }
    }

    private func setupStatusContainer() {
        if statusIconView.superview == nil {
            statusContainer.addSubview(statusIconView)
        }

        statusIconView.snp.remakeConstraints {
            $0.size.equalTo(Constants.statusIconSize)
            $0.directionalHorizontalEdges.equalToSuperview().inset(Padding.iconHorizontal)
            if sportType == .basketball {
                $0.centerY.equalToSuperview()
            } else {
                $0.top.equalToSuperview()
            }
        }

        statusTimeTextLabel.removeFromSuperview()

        guard sportType != .basketball else { return }

        statusTimeTextLabel.text = minuteText
        statusContainer.addSubview(statusTimeTextLabel)

        statusTimeTextLabel.snp.remakeConstraints {
            $0.top.equalTo(statusIconView.snp.bottom)
            $0.bottom.equalToSuperview()
            $0.centerX.equalTo(statusIconView.snp.centerX)
        }
    }

    private func setupPlayerContainer() {
        if playerNameLabel.superview == nil {
            playerContainer.addSubview(playerNameLabel)
        }

        let alignment: NSTextAlignment = isHomeTeam ?? false ? .left : .right

        playerNameLabel.text = player
        playerNameLabel.textAlignment = alignment

        playerNameLabel.snp.remakeConstraints {
            $0.top.equalToSuperview()
            $0.directionalHorizontalEdges.equalToSuperview()
        }

        incidentDescriptionLabel.removeFromSuperview()

        if let description = incidentDescription {
            incidentDescriptionLabel.text = description
            incidentDescriptionLabel.textAlignment = alignment
            playerContainer.addSubview(incidentDescriptionLabel)

            incidentDescriptionLabel.snp.remakeConstraints {
                $0.top.equalTo(playerNameLabel.snp.bottom)
                $0.directionalHorizontalEdges.equalToSuperview()
                $0.bottom.equalToSuperview()
            }
        } else {
            playerNameLabel.snp.makeConstraints { $0.bottom.equalToSuperview() }
        }
    }

    private func makeBasketballConstraints() {
        guard let isHome = isHomeTeam else { return }

        addSubview(statusTimeTextLabel)
        addSubview(horizontalSeparator)

        statusTimeTextLabel.text = minuteText
        statusTimeTextLabel.textAlignment = .center

        applyLayout(alignment: isHome ? .home : .away, includeScore: !(score?.isEmpty ?? true))

        statusTimeTextLabel.snp.remakeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(horizontalSeparator.snp.width)
        }

        horizontalSeparator.snp.remakeConstraints {
            $0.height.equalTo(Constants.separatorHeight)
            $0.width.equalTo(Constants.horizontalSeparatorWidth)
            $0.bottom.equalToSuperview()
            $0.centerX.equalTo(statusTimeTextLabel.snp.centerX)
        }
    }

    private func makeHomeConstraints() {
        applyLayout(alignment: .home, includeScore: !(score?.isEmpty ?? true))
    }

    private func makeAwayConstraints() {
        applyLayout(alignment: .away, includeScore: !(score?.isEmpty ?? true))
    }

    private func applyLayout(alignment: Alignment, includeScore: Bool) {
        let isHome = alignment == .home

        statusContainer.snp.remakeConstraints {
            if isHome {
                $0.leading.equalToSuperview()
            } else {
                $0.trailing.equalToSuperview()
            }
            $0.directionalVerticalEdges.equalToSuperview().inset(Padding.vertical)
        }

        verticalSeparator.snp.remakeConstraints {
            $0.width.equalTo(Constants.verticalSeparatorWidth)
            $0.verticalEdges.equalToSuperview().inset(Padding.separatorVertical)
            if isHome {
                $0.leading.equalTo(statusContainer.snp.trailing)
            } else {
                $0.trailing.equalTo(statusContainer.snp.leading)
            }
        }

        if includeScore, let scoreText = score {
            scoreTextLabel.text = scoreText
            scoreTextLabel.snp.remakeConstraints {
                if isHome {
                    $0.leading.equalTo(verticalSeparator.snp.trailing).offset(Padding.horizontal)
                } else {
                    $0.trailing.equalTo(verticalSeparator.snp.leading).offset(-Padding.horizontal)
                }
                $0.centerY.equalToSuperview()
                $0.width.equalTo(Constants.scoreWidth)
            }

            playerContainer.snp.remakeConstraints {
                if isHome {
                    $0.leading.equalTo(scoreTextLabel.snp.trailing).offset(Padding.horizontal)
                } else {
                    $0.trailing.equalTo(scoreTextLabel.snp.leading).offset(-Padding.horizontal)
                }
                $0.centerY.equalToSuperview()
            }
        } else {
            playerContainer.snp.remakeConstraints {
                if isHome {
                    $0.leading.equalTo(verticalSeparator.snp.trailing).offset(Padding.horizontal)
                    $0.trailing.equalToSuperview().inset(Padding.horizontal)
                } else {
                    $0.trailing.equalTo(verticalSeparator.snp.leading).offset(-Padding.horizontal)
                    $0.leading.equalToSuperview().inset(Padding.horizontal)
                }
                $0.centerY.equalToSuperview()
            }
        }
    }

    func cleanup() {
        type = nil
        minuteText = nil
        isHomeTeam = nil
        player = nil
        score = nil
        incidentDescription = nil
        sportType = nil
        statusIconView.image = nil
        statusTimeTextLabel.text = nil
        playerNameLabel.text = nil
        incidentDescriptionLabel.text = nil
        scoreTextLabel.text = nil
    }
}
