//
//  InfoCell.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 20.06.2025..
//

import SnapKit
import UIKit

class InfoCell: UICollectionViewCell {

    static let reuseIdentifier = "InfoCell"

    private let infoCellView = InfoCellView()

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
        infoCellView.cleanup()
    }

    func addViews() {
        contentView.addSubview(infoCellView)
    }

    func setupConstraints() {
        infoCellView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    func bind(_ infoCell: InfoCellViewModel) {
        infoCellView.configure(
            infoCell.name,
            infoCell.countryName,
            infoCell.imageUrl,
            infoCell.playersCountText,
            infoCell.foreignPlayersCountText
        )
    }
}
