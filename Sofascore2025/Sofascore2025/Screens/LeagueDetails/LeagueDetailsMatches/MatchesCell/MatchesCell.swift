//
//  MatchesCell.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 09.06.2025..
//

import UIKit
import SnapKit

class MatchesCell: UICollectionViewCell {

    static let reuseIdentifier = "MatchesCell"

    private let eventView = EventView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .surface1

        addViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        eventView.cleanup()
    }

    func addViews() {
        contentView.addSubview(eventView)
    }

    func setupConstraints() {
        eventView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    func bind(_ event: MatchesCellViewModel) {
        eventView.configure(
            event.startTimestampText,
            event.statusInfo.descriptionShort,
            event.statusInfo.color,
            event.homeTeamInfo,
            event.awayTeamInfo
        )
    }
}
