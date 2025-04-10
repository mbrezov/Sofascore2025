//
//  MatchHeroStatusUpcomingView.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 09.04.2025..
//

import SnapKit
import SofaAcademic
import UIKit

class MatchHeroStatusUpcomingView: BaseView {

    private enum Padding {

        static let top: CGFloat = 8
        static let statusLabelTop: CGFloat = 4
    }

    private let startDateLabel = UILabel()
    private let startTimeLabel = UILabel()

    override func addViews() {
        addSubview(startDateLabel)
        addSubview(startTimeLabel)
    }

    override func styleViews() {
        startDateLabel.font = .micro
        startDateLabel.textColor = .surfaceLv1

        startTimeLabel.font = .micro
        startTimeLabel.textColor = .surfaceLv1
    }

    override func setupConstraints() {
        startDateLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(Padding.top)
            $0.centerX.equalToSuperview()
        }

        startTimeLabel.snp.makeConstraints {
            $0.top.equalTo(startDateLabel.snp.bottom).offset(Padding.statusLabelTop)
            $0.centerX.bottom.equalToSuperview()
        }
    }

    func configure(dateText: String, startTimeText: String) {
        startDateLabel.setText(dateText, withLineHeight: 16)
        startTimeLabel.setText(startTimeText, withLineHeight: 16)
    }
}
