//
//  TournamentsCellView.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 20.06.2025..
//

import SnapKit
import SofaAcademic
import UIKit

class TournamentsCellView: BaseView {

    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: .tournamentsWrappedGridLayout())

    private var tournamentsCellViewModel: TournamentsCellViewModel?

    override func addViews() {
        addSubview(collectionView)
    }

    override func styleViews() {
        collectionView.backgroundColor = .surface1
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isScrollEnabled = false
        collectionView.contentInset = .zero
        collectionView.contentInsetAdjustmentBehavior = .never

        collectionView.register(
            TournamentsItemCell.self,
            forCellWithReuseIdentifier: TournamentsItemCell.reuseIdentifier
        )
    }

    override func setupConstraints() {
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    func configure(_ tournamentsCellViewModel: TournamentsCellViewModel) {
        self.tournamentsCellViewModel = tournamentsCellViewModel
        collectionView.reloadData()
        collectionView.collectionViewLayout.invalidateLayout()
    }
}

// MARK: - UICollectionViewDataSource

extension TournamentsCellView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tournamentsCellViewModel?.tournamentsCount ?? 0
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let tournaments = tournamentsCellViewModel?.tournaments else { return UICollectionViewCell() }
        let tournament = tournaments[indexPath.row]
        let viewModel = tournamentsCellViewModel?.makeTournamentsItemCellViewModel(for: tournament)

        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: TournamentsItemCell.reuseIdentifier,
            for: indexPath
        ) as? TournamentsItemCell,
              let viewModel = viewModel else {
            return UICollectionViewCell()
        }

        cell.bind(viewModel)
        return cell
    }
}
