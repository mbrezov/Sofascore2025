//
//  VenueCellView.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 20.06.2025..
//

import SnapKit
import SofaAcademic
import UIKit

class VenueCellView: BaseView {

    private enum Padding {

        static let horizontal: CGFloat = 16
        static let vertical: CGFloat = 8
    }

    private let nameLabel = UILabel()
    private let cityNameLabel = UILabel()

    override func addViews() {
        addSubview(nameLabel)
        addSubview(cityNameLabel)
    }

    override func styleViews() {
        backgroundColor = .surface1

        nameLabel.text = .stadium
        nameLabel.font = .body
        nameLabel.textColor = .surfaceLv1
        nameLabel.numberOfLines = 1
        nameLabel.lineBreakMode = .byTruncatingTail
        nameLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        nameLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)

        cityNameLabel.font = .body
        cityNameLabel.textColor = .surfaceLv1
        cityNameLabel.numberOfLines = 1
        cityNameLabel.lineBreakMode = .byTruncatingTail
        cityNameLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        cityNameLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
    }

    override func setupConstraints() {
        nameLabel.snp.makeConstraints {
            $0.directionalVerticalEdges.equalToSuperview().inset(Padding.vertical)
            $0.leading.equalToSuperview().inset(Padding.horizontal)
        }

        cityNameLabel.snp.makeConstraints {
            $0.directionalVerticalEdges.equalToSuperview().inset(Padding.vertical)
            $0.trailing.equalToSuperview().inset(Padding.horizontal)
        }
    }

    func configure(
        _ venueName: String
    ) {
        cityNameLabel.text = venueName
    }

    func cleanup() {
        cityNameLabel.text = nil
    }
}
