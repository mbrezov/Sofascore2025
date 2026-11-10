//
//  PlayerCellView.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 20.06.2025..
//

import SnapKit
import SofaAcademic
import UIKit

class PlayerCellView: BaseView {

    private enum Padding {

        static let horizontal: CGFloat = 16
        static let playerImageBottom: CGFloat = 8
        static let nameLabelTop: CGFloat = 10
        static let countryLabelTop: CGFloat = 4
        static let countryLabelBottom: CGFloat = 10
    }

    private enum Constants {

        static let iconSize: CGFloat = 40
    }

    private let playerImageView = UIImageView()
    private let nameLabel = UILabel()
    private let countryLabel = UILabel()

    override func addViews() {
        addSubview(playerImageView)
        addSubview(nameLabel)
        addSubview(countryLabel)
    }

    override func styleViews() {
        playerImageView.contentMode = .scaleAspectFit
        playerImageView.layer.cornerRadius = Constants.iconSize / 2
        playerImageView.layer.borderWidth = 1
        playerImageView.layer.borderColor = UIColor.surfaceLv4.cgColor
        playerImageView.clipsToBounds = true

        nameLabel.font = .body
        nameLabel.textColor = .surfaceLv1

        countryLabel.font = .assistive
        countryLabel.textColor = .surfaceLv2
    }

    override func setupConstraints() {
        playerImageView.snp.makeConstraints {
            $0.size.equalTo(Constants.iconSize)
            $0.leading.equalToSuperview().inset(Padding.horizontal)
            $0.directionalVerticalEdges.equalToSuperview().inset(Padding.playerImageBottom)
        }

        nameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(Padding.nameLabelTop)
            $0.leading.equalTo(playerImageView.snp.trailing).offset(Padding.horizontal)
            $0.trailing.equalToSuperview().offset(Padding.horizontal)
        }

        countryLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).inset(Padding.countryLabelTop)
            $0.leading.equalTo(nameLabel.snp.leading)
            $0.trailing.equalToSuperview().offset(Padding.horizontal)
            $0.bottom.equalToSuperview().inset(Padding.countryLabelBottom)
        }
    }

    func configure(
        _ nameText: String?,
        _ countryText: String?,
        _ imageUrl: URL?
    ) {
        if let name = nameText {
            nameLabel.setText(name, withLineHeight: 16)
        }

        if let country = countryText {
            countryLabel.setText(country, withLineHeight: 16)
        }

        playerImageView.setImageURL(imageUrl)
    }

    func cleanup() {
        nameLabel.text = nil
        countryLabel.text = nil
        playerImageView.image = nil
    }
}
