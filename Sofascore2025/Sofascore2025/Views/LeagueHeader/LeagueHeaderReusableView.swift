//
//  LeagueHeaderReusableView.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 24.03.2025..
//

import SnapKit
import UIKit

class LeagueHeaderReusableView: UICollectionReusableView {

    static let reuseIdentifier = "LeagueHeaderReusableView"

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

    override func prepareForReuse() {
        super.prepareForReuse()
        eventHeaderView.cleanup()
    }

    func addViews() {
        addSubview(eventHeaderView)
    }

    func setupConstraints() {
        eventHeaderView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    func bind(_ league: LeagueHeaderViewModel) {
        eventHeaderView.viewModel = league
    }
}
