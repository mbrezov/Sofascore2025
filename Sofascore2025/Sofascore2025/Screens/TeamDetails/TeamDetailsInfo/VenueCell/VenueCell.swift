//
//  VenueCell.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 20.06.2025..
//

import SnapKit
import UIKit

class VenueCell: UICollectionViewCell {

    static let reuseIdentifier = "VenueCell"

    private let venueCellView = VenueCellView()

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
        venueCellView.cleanup()
    }

    func addViews() {
        contentView.addSubview(venueCellView)
    }

    func setupConstraints() {
        venueCellView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    func bind(_ venueCell: VenueCellViewModel) {
        venueCellView.configure(
            venueCell.venueName
        )
    }
}
