//
//  EventsViewController.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 19.03.2025..
//

import SnapKit
import SofaAcademic
import UIKit

class EventsViewController: UIViewController, BaseViewProtocol {

    private enum Constants {

        static let collectionViewInsets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 8, right: 0)
    }

    private let data = Homework3DataSource()
    private var viewModel: EventsViewModel?
    private var eventsByLeague: [Int?: [Event]] = [:]

    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: .verticalFlowLayout())

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .surface1

        viewModel = EventsViewModel(events: data.events())
        if let viewModel = viewModel {
            eventsByLeague = viewModel.eventsByLeague
        }

        addViews()
        styleViews()
        setupConstraints()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        collectionView.reloadData()
    }

    func addViews() {
        view.addSubview(collectionView)
    }

    func styleViews() {
        collectionView.backgroundColor = .surface1
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(LeagueEventCell.self, forCellWithReuseIdentifier: LeagueEventCell.reuseIdentifier)
        collectionView.register(LeagueHeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: LeagueHeaderCell.reuseIdentifier)
        collectionView.register(LeagueSectionDividerView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: LeagueSectionDividerView.reuseIdentifier)

        collectionView.automaticallyAdjustsScrollIndicatorInsets = false
        let collectionViewScrollInsets = Constants.collectionViewInsets.bottom + view.safeAreaInsets.bottom
        collectionView.verticalScrollIndicatorInsets.bottom = collectionViewScrollInsets
    }

    func setupConstraints() {
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

// MARK: - UICollectionViewDataSource

extension EventsViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return eventsByLeague.keys.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let leagueId = viewModel?.leagueIDs[section]

        if let eventsForLeague = eventsByLeague[leagueId] {
            return eventsForLeague.count
        }
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let leagueId = viewModel?.leagueIDs[indexPath.section]

        if let eventsForLeague = eventsByLeague[leagueId] {
            let event = eventsForLeague[indexPath.row]

            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LeagueEventCell.reuseIdentifier, for: indexPath) as? LeagueEventCell else { return UICollectionViewCell() }

            let eventViewModel = EventViewModel(event: event)
            cell.bind(eventViewModel)

            return cell
        }

        return UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let leagueId = viewModel?.leagueIDs[indexPath.section]
            guard let league = viewModel?.getLeague(by: leagueId) else { return UICollectionReusableView() }

            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: LeagueHeaderCell.reuseIdentifier, for: indexPath) as? LeagueHeaderCell else { return UICollectionReusableView() }

            let leagueViewModel = LeagueViewModel(league: league)
            headerView.bind(leagueViewModel)

            return headerView
        }

        if kind == UICollectionView.elementKindSectionFooter {
            if indexPath.section == collectionView.numberOfSections - 1 {
                return UICollectionReusableView()
            }

            guard let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: LeagueSectionDividerView.reuseIdentifier, for: indexPath) as? LeagueSectionDividerView else { return UICollectionReusableView() }

            return footerView
        }

        return UICollectionReusableView()
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension EventsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width, height: LeagueEventCell.height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: LeagueHeaderCell.height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return section == collectionView.numberOfSections - 1 ? .zero : CGSize(width: collectionView.frame.width, height: LeagueSectionDividerView.height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return Constants.collectionViewInsets
    }
}
