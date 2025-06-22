//
//  MatchesHeaderReusableView.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 12.06.2025..
//

import SnapKit
import UIKit

class MatchesHeaderReusableView: UICollectionReusableView {

    private enum Padding {

        static let top: CGFloat = 24
        static let horizontal: CGFloat = 16
        static let bottom: CGFloat = 8
    }

    static let reuseIdentifier = "MatchesHeaderReusableView"

    private let leagueRoundsLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .surface

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
        leagueRoundsLabel.text = nil
    }

    func addViews() {
        addSubview(leagueRoundsLabel)
    }

    func styleViews() {
        leagueRoundsLabel.font = .headline3
        leagueRoundsLabel.textColor = .surfaceLv1
    }

    func setupConstraints() {
        leagueRoundsLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(Padding.top)
            $0.directionalHorizontalEdges.equalToSuperview().inset(Padding.horizontal)
            $0.bottom.equalToSuperview().inset(Padding.bottom)
        }
    }

    func bind(_ titleText: String) {
        leagueRoundsLabel.text = titleText
    }
}
