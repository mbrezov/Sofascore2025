//
//  LeagueHeaderCell.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 24.03.2025..
//

import SnapKit
import UIKit

class LeagueHeaderCell: UICollectionReusableView {

    static let reuseIdentifier = "LeagueHeaderCell"

    private let eventHeaderView = LeagueHeaderView()

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

    func addViews() {
        addSubview(eventHeaderView)
    }

    func setupConstraints() {
        eventHeaderView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    func bind(_ league: LeagueViewModel) {
        eventHeaderView.viewModel = league
    }
}
