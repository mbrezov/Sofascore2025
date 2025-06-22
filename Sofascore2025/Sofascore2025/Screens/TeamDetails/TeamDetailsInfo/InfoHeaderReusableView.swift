//
//  InfoHeaderReusableView.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 20.06.2025..
//

import SnapKit
import UIKit

class InfoHeaderReusableView: UICollectionReusableView {

    static let reuseIdentifier = "InfoHeaderReusableView"

    private let titleLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        addViews()
        styleViews()
        setupConstraints()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
    }

    func addViews() {
        addSubview(titleLabel)
    }

    func styleViews() {
        backgroundColor = .surface1

        titleLabel.font = .headline2
        titleLabel.textColor = .surfaceLv1
    }

    func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }

    func bind(_ title: String) {
        titleLabel.text = title
    }
}
