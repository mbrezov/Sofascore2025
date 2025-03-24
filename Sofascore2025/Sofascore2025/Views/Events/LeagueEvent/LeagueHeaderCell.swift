//
//  LeagueHeaderCell.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 24.03.2025..
//

import UIKit
import SnapKit

class LeagueHeaderCell: UICollectionViewCell {

    static let reuseIdentifier = "LeagueHeaderCell"

    static var height: CGFloat {
        LeagueHeaderView.height
    }

    private let leagueHeaderView = LeagueHeaderView()

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
        addSubview(leagueHeaderView)
    }

    func setupConstraints() {
        leagueHeaderView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    func bind(_ league: LeagueViewModel) {
        leagueHeaderView.viewModel = league
    }
}
