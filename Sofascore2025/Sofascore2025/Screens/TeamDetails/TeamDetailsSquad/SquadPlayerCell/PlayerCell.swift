//
//  PlayerCell.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 20.06.2025..
//

import UIKit
import SnapKit

class PlayerCell: UICollectionViewCell {

    static let reuseIdentifier = "PlayerCell"

    private let playerCellView = PlayerCellView()

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
        playerCellView.cleanup()
    }

    func addViews() {
        contentView.addSubview(playerCellView)
    }

    func setupConstraints() {
        playerCellView.snp.makeConstraints {
            $0.top.directionalHorizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview().inset(8)
        }
    }

    func bind(_ player: PlayerCellViewModel) {
        playerCellView.configure(
            player.name,
            player.countryName,
            player.imageUrl
        )
    }
}
