//
//  BackNavigationBarView.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 08.04.2025..
//

import SnapKit
import SofaAcademic
import UIKit

class BackNavigationBarView: BaseView {

    private enum Constants {

        static let iconSize: CGFloat = 24
    }

    private enum Padding {

        static let backButtonLeft: CGFloat = 16
        static let backbuttonBottom: CGFloat = 12
        static let titleViewLeft: CGFloat = 24
        static let titleLeft: CGFloat = 32
        static let titleRight: CGFloat = 16
    }

    weak var delegate: BackNavigationBarViewDelegate?

    private let backButton = UIButton()

    private var titleLabel: UILabel?
    private var titleView: UIView?

    override func addViews() {
        addSubview(backButton)
    }

    override func styleViews() {
        backButton.setImage(.icArrowBack.withRenderingMode(.alwaysTemplate), for: .normal)
    }

    override func setupConstraints() {
        backButton.snp.makeConstraints {
            $0.size.equalTo(Constants.iconSize)
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.leading.equalToSuperview().inset(Padding.backButtonLeft)
            $0.bottom.equalToSuperview().inset(Padding.backbuttonBottom)
        }

        if let titleLabel = titleLabel {
            titleLabel.snp.makeConstraints {
                $0.leading.equalTo(backButton.snp.trailing).offset(Padding.titleLeft)
                $0.centerY.equalTo(backButton.snp.centerY)
                $0.trailing.equalToSuperview().inset(Padding.titleRight)
            }
        }

        if let titleView = titleView {
            titleView.snp.makeConstraints {
                $0.leading.equalTo(backButton.snp.trailing).offset(Padding.titleViewLeft)
                $0.centerY.equalTo(backButton.snp.centerY)
            }
        }
    }

    override func setupGestureRecognizers() {
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }

    func configure(tintColor: UIColor = .surface1, bgColor: UIColor? = .clear, title: String? = nil, titleView: UIView? = nil) {

        backgroundColor = bgColor
        backButton.tintColor = tintColor

        if let titleText = title {
            let titleLabel = UILabel()
            self.titleLabel = titleLabel
            titleLabel.setText(titleText, withLineHeight: 28)
            titleLabel.font = .headline1
            titleLabel.textColor = tintColor
            addSubview(titleLabel)
            setupConstraints()
        }

        if let titleView = titleView {
            self.titleView = titleView
            addSubview(titleView)
            setupConstraints()
        }
    }

    @objc private func backButtonTapped() {
        delegate?.goBack()
    }
}

// MARK: - Navigation - BackNavigationBarViewDelegate

protocol BackNavigationBarViewDelegate: AnyObject {

    func goBack()
}
