//
//  StandingsCell.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 12.06.2025..
//

import SnapKit
import UIKit

class StandingsCell: UICollectionViewCell {

    static let reuseIdentifier = "StandingsCell"

    private let standingsRowView = StandingsRowView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        addViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        standingsRowView.cleanup()
    }

    func addViews() {
        contentView.addSubview(standingsRowView)
    }

    func setupConstraints() {
        standingsRowView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    func bind(_ sportView: SportsCellViewModelProtocol) {
        standingsRowView.configure(
            isHeader: false,
            sportView.positionText,
            sportView.teamName,
            sportView.stats.map(\.value),
            sportView.stats.map(\.labelWidth),
            sportView.statisItemsSpacing
        )
    }
}
