//
//  SportSelectorMenuButton.swift.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 18.03.2025..
//

import UIKit
import SnapKit

class SportSelectorMenuButton: UIButton {

    private enum Padding {

        static let iconTop: CGFloat = 4
        static let labelEdges: CGFloat = 8
    }

    private enum Constants {

        static let iconSize: CGFloat = 16
        static let iconSpacing: CGFloat = 4
        static let lineHeight: CGFloat = 16
    }

    private let iconImageView = UIImageView()
    private let nameLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButton()
    }

    private func setupButton() {
        addViews()
        styleViews()
        setupConstraints()
    }

    func addViews() {
        addSubview(iconImageView)
        addSubview(nameLabel)
    }

    func styleViews() {
        iconImageView.tintColor = .surface1
        iconImageView.contentMode = .scaleAspectFit

        nameLabel.textColor = .surface1
        nameLabel.font = .body
        nameLabel.textAlignment = .center
    }

    func setupConstraints() {
        iconImageView.snp.makeConstraints {
            $0.size.equalTo(Constants.iconSize)
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(Padding.iconTop)
        }

        nameLabel.snp.makeConstraints {
            $0.top.equalTo(iconImageView.snp.bottom).offset(Constants.iconSpacing)
            $0.leading.trailing.bottom.equalToSuperview().inset(Padding.labelEdges)
        }
    }

    func setup(name: String, image: UIImage, tag: Int, selector: Selector) {
        iconImageView.image = image

        nameLabel.text = name
        nameLabel.setLineHeight(Constants.lineHeight)

        self.tag = tag
        addTarget(target, action: selector, for: .touchUpInside)
    }
}
