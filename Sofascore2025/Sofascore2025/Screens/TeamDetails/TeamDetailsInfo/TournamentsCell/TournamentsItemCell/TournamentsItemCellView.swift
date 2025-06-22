//
//  TournamentsItemCellView.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 20.06.2025..
//

import SnapKit
import SofaAcademic
import UIKit

class TournamentsItemCellView: BaseView {

    private enum Padding {

        static let horizontal: CGFloat = 12
        static let logoImageTop: CGFloat = 8
        static let nameLabelTop: CGFloat = 4
        static let nameLabelBottom: CGFloat = 12
    }

    private enum Constants {

        static let labelHeight: CGFloat = 32
        static let iconSize: CGFloat = 40
    }

    private let logoImageView = UIImageView()
    private let nameLabel = UILabel()

    override func addViews() {
        addSubview(logoImageView)
        addSubview(nameLabel)
    }

    override func styleViews() {
        logoImageView.contentMode = .scaleAspectFit

        nameLabel.font = .micro
        nameLabel.textColor = .surfaceLv2
        nameLabel.textAlignment = .center
        nameLabel.numberOfLines = 0
    }

    override func setupConstraints() {
        logoImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(Padding.logoImageTop)
            $0.size.equalTo(Constants.iconSize)
            $0.centerX.equalToSuperview()
        }

        nameLabel.snp.makeConstraints {
            $0.top.equalTo(logoImageView.snp.bottom).offset(Padding.nameLabelTop)
            $0.directionalHorizontalEdges.equalToSuperview().inset(Padding.horizontal)
            $0.bottom.equalToSuperview().inset(Padding.nameLabelBottom)
            $0.height.equalTo(Constants.labelHeight)
        }
    }

    func configure(
        _ logoUrl: URL?,
        _ name: String
    ) {
        nameLabel.setText(name, withLineHeight: 16)
        logoImageView.setImageURL(logoUrl)
    }

    func cleanup() {
        nameLabel.text = nil
        logoImageView.image = nil
    }
}
