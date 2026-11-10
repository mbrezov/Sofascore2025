//
//  StandingsCollectionViewController.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 05.06.2025..
//

import SnapKit
import SofaAcademic
import UIKit

class StandingsViewController: UIViewController, BaseViewProtocol {

    private enum Constants {

        static let contentInset: CGFloat = 48
        static let scrollInsets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: Constants.contentInset, right: 0)
    }

    private let viewModel: StandingsViewModel
    weak var scrollDelegate: ChildScrollReportingProtocol?

    private let collectionView: UICollectionView
    private let emptyStateLabel = UILabel()

    var hasNoStandings: Bool {
        viewModel.leagueStandings.isEmpty
    }

    init(viewModel: StandingsViewModel) {
        self.viewModel = viewModel

        let layout = UICollectionViewCompositionalLayout.leagueDetailsStandingsCompositionalLayout()
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .surface1
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self

        collectionView.register(
            StandingsCell.self,
            forCellWithReuseIdentifier: StandingsCell.reuseIdentifier
        )
        collectionView.register(
            StandingsHeaderReusableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: StandingsHeaderReusableView.reuseIdentifier
        )

        collectionView.automaticallyAdjustsScrollIndicatorInsets = false
        collectionView.verticalScrollIndicatorInsets.bottom = Constants.scrollInsets.bottom + view.safeAreaInsets.bottom
        collectionView.bounces = false
        collectionView.contentInset.bottom = Constants.contentInset

        addViews()
        setupConstraints()
    }

    func addViews() {
        view.addSubview(collectionView)
        setupEmptyStateLabel()
    }

    func setupConstraints() {
        collectionView.snp.makeConstraints {
            $0.top.directionalHorizontalEdges.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateEmptyState()
    }

    private func setupEmptyStateLabel() {
        collectionView.backgroundView = emptyStateLabel
        emptyStateLabel.text = .teamSquadEmptyStateMessage
        emptyStateLabel.textAlignment = .center
        emptyStateLabel.textColor = .surfaceLv2
    }

    private func updateEmptyState() {
        collectionView.backgroundView?.isHidden = !hasNoStandings
    }
}

// MARK: - ChildScrollReportingProtocol

extension StandingsViewController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollDelegate?.childViewControllerDidScroll(scrollView)
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate

extension StandingsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        hasNoStandings ? 0 : 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.leagueStandings.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let standings = viewModel.leagueStandings[indexPath.row]
        let standingsCellViewModel = viewModel.makeStandingsCellViewModel(for: standings)
        let sportCellViewModel = standingsCellViewModel.makeSportCellViewModel()

        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: StandingsCell.reuseIdentifier,
            for: indexPath
        ) as? StandingsCell else {
            return UICollectionViewCell()
        }

        if let sportCellViewModel = sportCellViewModel {
            cell.bind(sportCellViewModel)
        }

        return cell
    }

    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            var sportCellViewModel: SportsCellViewModelProtocol?
            if let standings = viewModel.leagueStandings.first {
                let standingsCellViewModel = viewModel.makeStandingsCellViewModel(for: standings)
                sportCellViewModel = standingsCellViewModel.makeSportCellViewModel()
            }

            guard let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: StandingsHeaderReusableView.reuseIdentifier,
                for: indexPath
            ) as? StandingsHeaderReusableView else {
                return UICollectionReusableView()
            }

            if let sportCellViewModel = sportCellViewModel {
                header.bind(sportCellViewModel)
            }

            return header

        default:
            return UICollectionReusableView()
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let standings = viewModel.leagueStandings[indexPath.row]
        let teamDetailsViewModel = TeamDetailsViewModel(team: standings.team)
        let teamDetailsVC = TeamDetailsViewController(teamDetailsViewModel)
        teamDetailsVC.delegate = self
        push(teamDetailsVC, animated: true)
    }
}

//MARK: - TeamDetailsViewControllerDelegate

extension StandingsViewController: TeamDetailsViewControllerDelegate {
    func teamDetailsViewControllerDidPressBack(_ teamDetailsViewController: TeamDetailsViewController) {
        pop(animated: true)
    }
}

//MARK: - ScrollableContentControllerProtocol

extension StandingsViewController: ScrollableContentControllerProtocol {
    var scrollableView: UIScrollView? {
        collectionView
    }
}
