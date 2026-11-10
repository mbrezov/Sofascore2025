//
//  StandingsHeaderReusableView.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 12.06.2025..
//

import SnapKit
import UIKit

class StandingsHeaderReusableView: UICollectionReusableView {

    static let reuseIdentifier = "StandingsHeaderReusableView"

    private let standingsHeaderView = StandingsRowView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .surface1

        addViews()
        setupConstraints()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        standingsHeaderView.cleanup()
    }

    func addViews() {
        addSubview(standingsHeaderView)
    }

    func setupConstraints() {
        standingsHeaderView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    func bind(_ sport: SportsCellViewModelProtocol) {
        standingsHeaderView.configure(
            isHeader: true,
            .positionTitle,
            .teamTitle,
            sport.stats.map(\.label),
            sport.stats.map(\.labelWidth),
            sport.statisItemsSpacing
        )
    }
}
