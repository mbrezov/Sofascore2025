//
//  InfoCellView.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 20.06.2025..
//

import SnapKit
import SofaAcademic
import UIKit

class InfoCellView: BaseView {

    private enum Padding {

        static let horizontal: CGFloat = 12
        static let vertical: CGFloat = 8
        static let playersTitleTop: CGFloat = 4
    }

    private enum Constants {

        static let horizontalDividerHeight: CGFloat = 1
        static let iconSize: CGFloat = 40
    }

    private let managerView = PlayerCellView()
    private let totalPlayersImageView = UIImageView()
    private let totalPlayersLabel = UILabel()
    private let totalPlayersTitleLabel = UILabel()
    private let totalPlayersContainerView = UIView()
    private let foreignPlayersImageView = UIImageView()
    private let foreignPlayersLabel = UILabel()
    private let foreignPlayersTitleLabel = UILabel()
    private let foreignPlayersContainerView = UIView()
    private let statsStackView = UIStackView()
    private let horizontalDivider = UIView()

    override func addViews() {
        addSubview(managerView)
        addSubview(horizontalDivider)
        addSubview(statsStackView)
        totalPlayersContainerView.addSubview(totalPlayersImageView)
        totalPlayersContainerView.addSubview(totalPlayersLabel)
        totalPlayersContainerView.addSubview(totalPlayersTitleLabel)
        foreignPlayersContainerView.addSubview(foreignPlayersImageView)
        foreignPlayersContainerView.addSubview(foreignPlayersLabel)
        foreignPlayersContainerView.addSubview(foreignPlayersTitleLabel)
        statsStackView.addArrangedSubview(totalPlayersContainerView)
        statsStackView.addArrangedSubview(foreignPlayersContainerView)
    }

    override func styleViews() {
        backgroundColor = .surface1

        totalPlayersImageView.contentMode = .scaleAspectFit
        totalPlayersImageView.image = .icTeam

        foreignPlayersImageView.contentMode = .scaleAspectFit
        foreignPlayersImageView.image = .icPieChart

        totalPlayersLabel.font = .body
        totalPlayersLabel.textColor = .primaryDefault
        totalPlayersTitleLabel.setText(.totalPlayersTitle, withLineHeight: 32)
        totalPlayersTitleLabel.font = .micro
        totalPlayersTitleLabel.textColor = .surfaceLv2
        totalPlayersTitleLabel.textAlignment = .center

        foreignPlayersLabel.font = .body
        foreignPlayersLabel.textColor = .primaryDefault
        foreignPlayersTitleLabel.setText(.foreignPlayersTitle, withLineHeight: 32)
        foreignPlayersTitleLabel.font = .micro
        foreignPlayersTitleLabel.textColor = .surfaceLv2
        foreignPlayersTitleLabel.textAlignment = .center

        horizontalDivider.backgroundColor = .surfaceLv4

        statsStackView.axis = .horizontal
        statsStackView.distribution = .fillEqually
        statsStackView.spacing = 0
    }

    override func setupConstraints() {
        managerView.snp.makeConstraints {
            $0.top.directionalHorizontalEdges.equalToSuperview()
        }

        horizontalDivider.snp.makeConstraints {
            $0.top.equalTo(managerView.snp.bottom).offset(Padding.vertical)
            $0.height.equalTo(Constants.horizontalDividerHeight)
            $0.directionalHorizontalEdges.equalToSuperview()
        }

        setupTotalPlayersContainerView()
        setupForeignPlayersContainerView()

        statsStackView.snp.makeConstraints {
            $0.top.equalTo(horizontalDivider.snp.bottom)
            $0.bottom.directionalHorizontalEdges.equalToSuperview()
        }
    }

    private func setupTotalPlayersContainerView() {
        totalPlayersImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(Padding.vertical)
            $0.size.equalTo(Constants.iconSize)
            $0.centerX.equalToSuperview()
        }

        totalPlayersLabel.snp.makeConstraints {
            $0.top.equalTo(totalPlayersImageView.snp.bottom).offset(Padding.vertical)
            $0.centerX.equalToSuperview()
        }

        totalPlayersTitleLabel.snp.makeConstraints {
            $0.top.equalTo(totalPlayersLabel.snp.bottom).offset(Padding.playersTitleTop)
            $0.directionalHorizontalEdges.equalToSuperview().inset(Padding.horizontal)
            $0.bottom.equalToSuperview().inset(Padding.vertical)
        }
    }

    private func setupForeignPlayersContainerView() {
        foreignPlayersImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(Padding.vertical)
            $0.size.equalTo(Constants.iconSize)
            $0.centerX.equalToSuperview()
        }

        foreignPlayersLabel.snp.makeConstraints {
            $0.top.equalTo(foreignPlayersImageView.snp.bottom).offset(Padding.vertical)
            $0.centerX.equalToSuperview()
        }

        foreignPlayersTitleLabel.snp.makeConstraints {
            $0.top.equalTo(foreignPlayersLabel.snp.bottom).offset(Padding.playersTitleTop)
            $0.directionalHorizontalEdges.equalToSuperview().inset(Padding.horizontal)
            $0.bottom.equalToSuperview().inset(Padding.vertical)
        }
    }

    func configure(
        _ name: String,
        _ countryName: String?,
        _ imageUrl: URL?,
        _ totalPlayersText: String,
        _ foreignPlayersText: String
    ) {
        managerView.configure(
            name,
            countryName,
            imageUrl
        )
        totalPlayersLabel.text = totalPlayersText
        foreignPlayersLabel.text = foreignPlayersText
    }

    func cleanup() {
        totalPlayersLabel.text = nil
        foreignPlayersLabel.text = nil
    }
}
