//
//  TournamentsItemCell.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 20.06.2025..
//

import SnapKit
import UIKit

class TournamentsItemCell: UICollectionViewCell {

    static let reuseIdentifier = "TournamentsItemCell"

    private let tournamentsItemCellView = TournamentsItemCellView()

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
        tournamentsItemCellView.cleanup()
    }

    func addViews() {
        contentView.addSubview(tournamentsItemCellView)
    }

    func setupConstraints() {
        tournamentsItemCellView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    func bind(_ ItemCell: TournamentsItemCellViewModel) {
        tournamentsItemCellView.configure(
            ItemCell.logoURL,
            ItemCell.name
        )
    }
}
