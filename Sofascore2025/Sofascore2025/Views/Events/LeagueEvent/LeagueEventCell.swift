//
//  LeagueEventCell.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 19.03.2025..
//

import UIKit
import SnapKit

class LeagueEventCell: UICollectionViewCell {

    static let reuseIdentifier = "LeagueEventCell"

    static var height: CGFloat {
        LeagueEventView.height
    }

    private let leagueEventView = LeagueEventView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        addViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func addViews() {
        contentView.addSubview(leagueEventView)
    }

    func setupConstraints() {
        leagueEventView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    func bind(_ event: EventViewModel) {
        leagueEventView.viewModel = event
    }
}
