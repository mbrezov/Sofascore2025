//
//  SquadHeaderReusableView.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 20.06.2025..
//

import SnapKit
import UIKit

class SquadHeaderReusableView: UICollectionReusableView {

    private enum Padding {

        static let top: CGFloat = 24
        static let horizontal: CGFloat = 16
        static let bottom: CGFloat = 8
    }

    static let reuseIdentifier = "SquadHeaderReusableView"

    private let titleLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear

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
        titleLabel.font = .headline3
        titleLabel.textColor = .surfaceLv1
        titleLabel.numberOfLines = 1
    }

    func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(Padding.top)
            $0.directionalHorizontalEdges.equalToSuperview().inset(Padding.horizontal)
            $0.bottom.equalToSuperview().inset(Padding.bottom)
        }
    }

    func bind(title: String) {
        titleLabel.text = title
    }
}
