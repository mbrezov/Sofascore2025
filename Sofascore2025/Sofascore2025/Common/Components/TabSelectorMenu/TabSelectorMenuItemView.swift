//
//  TabSelectorMenuItemView.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 08.06.2025..
//

import SnapKit
import SofaAcademic
import UIKit

class TabSelectorMenuItemView: BaseView {

    private enum Padding {

        static let vertical: CGFloat = 16
        static let horizontal: CGFloat = 8
    }

    var onTap: (() -> Void)?

    private let nameLabel = UILabel()

    override func addViews() {
        addSubview(nameLabel)
    }

    override func styleViews() {
        nameLabel.textColor = .surface1
        nameLabel.font = .body
        nameLabel.textAlignment = .center
    }

    override func setupConstraints() {
        nameLabel.snp.makeConstraints {
            $0.directionalVerticalEdges.equalToSuperview().inset(Padding.vertical)
            $0.directionalHorizontalEdges.equalToSuperview().inset(Padding.horizontal)
        }
    }

    override func setupBinding() {
        let touchUpInside = UITapGestureRecognizer(target: self, action: #selector(tapped(_:)))
        addGestureRecognizer(touchUpInside)
    }

    func setup(name: String) {
        nameLabel.setText(name, withLineHeight: 16)
    }

    @objc private func tapped(_ sender: UITapGestureRecognizer) {
        onTap?()
    }
}
