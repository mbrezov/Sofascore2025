//
//  SettingsRowView.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 26.04.2025..
//

import SnapKit
import SofaAcademic
import UIKit

class SettingsRowView: BaseView {

    private enum Padding {

        static let horizontal: CGFloat = 16
        static let vertical: CGFloat = 12
        static let subtitleTop: CGFloat = 4
    }

    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()

    override func addViews() {
        addSubview(titleLabel)
        addSubview(subtitleLabel)
    }

    override func styleViews() {
        backgroundColor = .surface1

        titleLabel.font = .assistive
        titleLabel.textColor = .primaryDefault

        subtitleLabel.font = .body
        subtitleLabel.textColor = .surfaceLv1
    }

    override func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(Padding.vertical)
            $0.directionalHorizontalEdges.equalToSuperview().inset(Padding.horizontal)
        }

        subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(Padding.subtitleTop)
            $0.directionalHorizontalEdges.equalToSuperview().inset(Padding.horizontal)
            $0.bottom.equalToSuperview().inset(Padding.vertical)
        }
    }

    func configure(_ title: String, _ subtitle: String) {
        titleLabel.text = title
        subtitleLabel.text = subtitle
    }

    func cleanup() {
        titleLabel.text = nil
        subtitleLabel.text = nil
    }
}
