//
//  TournamentsCell.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 20.06.2025..
//

import SnapKit
import UIKit

class TournamentsCell: UICollectionViewCell {

    static let reuseIdentifier = "TournamentsCell"

    private let tournamentsCellView = TournamentsCellView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        addViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func addViews() {
        contentView.addSubview(tournamentsCellView)
    }

    func setupConstraints() {
        tournamentsCellView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    func bind(_ tournamentsCellViewModel: TournamentsCellViewModel) {
        tournamentsCellView.configure(
            tournamentsCellViewModel
        )
    }
}
