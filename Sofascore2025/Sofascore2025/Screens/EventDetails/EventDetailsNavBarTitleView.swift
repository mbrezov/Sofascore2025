//
//  EventDetailsNavBarTitleView.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 09.04.2025..
//

import SnapKit
import SofaAcademic
import UIKit

class EventDetailsNavBarTitleView: BaseView {

    private enum Padding {

        static let logoRight: CGFloat = 8
        static let titleLabelRight: CGFloat = 16
    }

    private enum Constants {

        static let imageSize: CGFloat = 16
    }

    private let logoImageView = UIImageView()
    private let titleLabel = UILabel()

    override func addViews() {
        addSubview(logoImageView)
        addSubview(titleLabel)
    }

    override func styleViews() {
        logoImageView.contentMode = .scaleAspectFit

        titleLabel.font = .micro
        titleLabel.textColor = .surfaceLv2
    }

    override func setupConstraints() {
        logoImageView.snp.makeConstraints {
            $0.leading.directionalVerticalEdges.equalToSuperview()
            $0.size.equalTo(Constants.imageSize)
        }

        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(logoImageView.snp.trailing).offset(Padding.logoRight)
            $0.centerY.equalTo(logoImageView.snp.centerY)
            $0.trailing.equalToSuperview().inset(Padding.titleLabelRight)
        }
    }

    func configure(logo: URL?, sport: String?, country: String?, leagueName: String?, roundText: String) {
        logoImageView.setImageURL(logo)

        let parts: [String] = [sport, country, leagueName, roundText].compactMap { $0 }
        let title: String = parts.joined(separator: ", ")
        titleLabel.setText(title, withLineHeight: 16)
    }
}
