//
//  SportSelectorMenuView.swift.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 18.03.2025..
//

import SnapKit
import SofaAcademic
import UIKit

class SportSelectorMenuView: BaseView {

    private enum Padding {

        static let iconTop: CGFloat = 4
        static let labelEdges: CGFloat = 8
    }

    private enum Constants {

        static let iconSize: CGFloat = 16
        static let iconSpacing: CGFloat = 4
    }

    var onTap: (() -> Void)?

    private let iconImageView = UIImageView()
    private let nameLabel = UILabel()

    override func addViews() {
        addSubview(iconImageView)
        addSubview(nameLabel)
    }

    override func styleViews() {
        iconImageView.tintColor = .surface1
        iconImageView.contentMode = .scaleAspectFit

        nameLabel.textColor = .surface1
        nameLabel.font = .body
        nameLabel.textAlignment = .center
    }

    override func setupConstraints() {
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

    override func setupBinding() {
        let touchUpInside = UITapGestureRecognizer(target: self, action: #selector(tapped(_:)))
        addGestureRecognizer(touchUpInside)
    }

    func setup(name: String, image: UIImage, onTap: (() -> Void)? = nil) {
        iconImageView.image = image
        nameLabel.setText(name, withLineHeight: 16)
        self.onTap = onTap
    }

    @objc private func tapped(_ sender: UITapGestureRecognizer) {
        onTap?()
    }
}
