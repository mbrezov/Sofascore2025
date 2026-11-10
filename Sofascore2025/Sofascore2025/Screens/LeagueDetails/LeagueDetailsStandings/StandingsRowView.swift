//
//  StandingsRowView.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 12.06.2025..
//

import SnapKit
import SofaAcademic
import UIKit

class StandingsRowView: BaseView {

    private enum Padding {

        static let horizontal: CGFloat = 8
        static let teamNameLabelLeft: CGFloat = 16
        static let vertical: CGFloat = 16
        static let circleHorizontal: CGFloat = 8
    }

    private enum Constants {

        static let circleSize: CGFloat = 24
    }

    private let positionLabel = UILabel()
    private let teamLabel = UILabel()
    private let statsStackView = UIStackView()

    override func addViews() {
        addSubview(teamLabel)
        addSubview(statsStackView)
    }

    override func styleViews() {
        positionLabel.font = .body
        positionLabel.textAlignment = .center

        teamLabel.font = .body
        teamLabel.lineBreakMode = .byTruncatingTail

        statsStackView.axis = .horizontal
        statsStackView.alignment = .center
        statsStackView.distribution = .fill
    }

    override func setupConstraints() {
        statsStackView.snp.makeConstraints {
            $0.leading.greaterThanOrEqualTo(teamLabel.snp.trailing).offset(Padding.horizontal)
            $0.trailing.equalToSuperview().inset(Padding.horizontal)
            $0.directionalVerticalEdges.equalToSuperview().inset(16)
        }
    }

    func configure(
        isHeader: Bool,
        _ positionText: String,
        _ teamName: String,
        _ stats: [String],
        _ statLabelWidth: [CGFloat],
        _ statsItemsSpacing: CGFloat
    ) {
        positionLabel.text = positionText
        teamLabel.text = teamName

        setupPositionAndTeamLayout(isHeader)

        let textColor: UIColor = isHeader ? .surfaceLv2 : .surfaceLv1
        teamLabel.textColor = textColor
        positionLabel.textColor = textColor

        statsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }

        for (index, stat) in stats.enumerated() {
            let width = statLabelWidth[index]

            let label = UILabel()
            label.text = stat
            label.font = .body
            label.textColor = textColor
            label.textAlignment = .center
            label.snp.makeConstraints {
                $0.width.equalTo(width)
            }
            statsStackView.addArrangedSubview(label)
        }
        statsStackView.spacing = statsItemsSpacing
    }

    private func setupPositionAndTeamLayout(_ isHeader: Bool) {
        if isHeader {
            addSubview(positionLabel)

            positionLabel.snp.makeConstraints {
                $0.leading.directionalVerticalEdges.equalToSuperview().inset(Padding.horizontal)
            }

            teamLabel.snp.makeConstraints {
                $0.leading.equalTo(positionLabel.snp.trailing).offset(Padding.teamNameLabelLeft)
                $0.directionalVerticalEdges.equalToSuperview().inset(Padding.horizontal)
            }
        } else {
            let circleBackgroundView = UIView()
            addSubview(circleBackgroundView)
            circleBackgroundView.addSubview(positionLabel)

            circleBackgroundView.backgroundColor = .secondaryDefault
            circleBackgroundView.clipsToBounds = true
            circleBackgroundView.layer.cornerRadius = Constants.circleSize / 2

            circleBackgroundView.snp.makeConstraints {
                $0.leading.equalToSuperview().inset(Padding.circleHorizontal)
                $0.centerY.equalToSuperview()
                $0.size.equalTo(Constants.circleSize)
            }

            positionLabel.snp.makeConstraints {
                $0.center.equalToSuperview()
            }

            teamLabel.snp.makeConstraints {
                $0.leading.equalTo(circleBackgroundView.snp.trailing).offset(Padding.circleHorizontal)
                $0.directionalVerticalEdges.equalToSuperview().inset(Padding.horizontal)
            }
        }
    }

    func cleanup() {
        positionLabel.text = nil
        teamLabel.text = nil
        statsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
    }
}
