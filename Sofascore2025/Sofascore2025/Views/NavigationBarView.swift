//
//  NavigationBarView.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 08.04.2025..
//

import SnapKit
import SofaAcademic
import UIKit

protocol NavigationBarViewDelegate: AnyObject {

    func navigationBarViewDidPressBack(_ navigationBarView: NavigationBarView)
}

class NavigationBarView: BaseView {

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

    weak var delegate: NavigationBarViewDelegate?

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
    }

    override func setupGestureRecognizers() {
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }

    @objc private func backButtonTapped(_ navigationBarView: UIView) {
        delegate?.navigationBarViewDidPressBack(self)
    }

    // MARK: - Setup

    func setTitle(_ title: String) {
        let titleLabel = UILabel()
        self.titleLabel = titleLabel
        titleLabel.setText(title, withLineHeight: 28)
        titleLabel.font = .headline1
        titleLabel.textColor = tintColor
        addSubview(titleLabel)
        setupTitleLabel()
    }

    func setTitleView(_ titleView: UIView?) {
        guard let titleView = titleView else { return }
        self.titleView = titleView
        addSubview(titleView)
        setupTitleView()
    }

    private func setupTitleLabel() {
        guard let titleLabel = titleLabel, titleView == nil else { return }
        titleLabel.snp.remakeConstraints {
            $0.leading.equalTo(backButton.snp.trailing).offset(Padding.titleLeft)
            $0.centerY.equalTo(backButton.snp.centerY)
            $0.trailing.equalToSuperview().inset(Padding.titleRight)
        }
    }

    private func setupTitleView() {
        guard let titleView = titleView else { return }
        titleLabel?.removeFromSuperview()
        titleView.snp.remakeConstraints {
            $0.leading.equalTo(backButton.snp.trailing).offset(Padding.titleViewLeft)
            $0.centerY.equalTo(backButton.snp.centerY)
        }
    }
}
