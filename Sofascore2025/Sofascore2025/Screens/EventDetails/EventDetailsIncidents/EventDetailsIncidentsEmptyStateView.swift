//
//  EventDetailsIncidentsEmptyStateView.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 03.06.2025..
//

import SofaAcademic
import SnapKit
import UIKit

class EventDetailsIncidentsEmptyStateView: BaseView {

    private enum Padding {

        static let emptyStateViewTop: CGFloat = 8
        static let emptyStateViewHorizontal: CGFloat = 8
        static let horizontal: CGFloat = 16
        static let buttonTop: CGFloat = 16
        static let buttonBottom: CGFloat = 32
    }

    private enum Constants {

        static let cornerRadius: CGFloat = 8
    }

    private let viewTurnamentDetailsButton = OutlineButton()
    private let emptyStateMessageView = UIView()
    private let emptyStateMessageLabel = UILabel()

    override func addViews() {
        addSubview(emptyStateMessageView)
        emptyStateMessageView.addSubview(emptyStateMessageLabel)
        addSubview(viewTurnamentDetailsButton)
    }

    override func styleViews() {
        backgroundColor = .surface1

        emptyStateMessageView.backgroundColor = .surface2
        emptyStateMessageView.layer.cornerRadius = Constants.cornerRadius

        emptyStateMessageLabel.text = .incidentsEmptyStateMessage
        emptyStateMessageLabel.textColor = .surfaceLv2
        emptyStateMessageLabel.font = .body

        viewTurnamentDetailsButton.setTitle(.incidentsEmptyStateButtonTitle, for: .normal)
        viewTurnamentDetailsButton.setTitleColor(.primaryDefault, for: .normal)
    }

    override func setupConstraints() {
        emptyStateMessageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(Padding.emptyStateViewTop)
            $0.directionalHorizontalEdges.equalToSuperview().inset(Padding.emptyStateViewHorizontal)
        }

        emptyStateMessageLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.directionalVerticalEdges.equalToSuperview().inset(Padding.horizontal)
        }

        viewTurnamentDetailsButton.snp.makeConstraints {
            $0.top.equalTo(emptyStateMessageView.snp.bottom).offset(Padding.buttonTop)
            $0.bottom.equalToSuperview().inset(Padding.buttonBottom)
            $0.centerX.equalToSuperview()
        }
    }
}
