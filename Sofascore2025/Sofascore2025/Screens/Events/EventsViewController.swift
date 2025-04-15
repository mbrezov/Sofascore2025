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

        static let scrollInsets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 8, right: 0)
    }

    private var viewModel: EventsViewModel

    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: .verticalCompositionalLayout())
    private let emptyStateLabel = UILabel()
    private let loadingIndicator = UIActivityIndicatorView(style: .medium)

    init(viewModel: EventsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .surface1

        addViews()
        styleViews()
        setupConstraints()
        setupBinding()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        collectionView.reloadData()
    }

    func addViews() {
        view.addSubview(collectionView)
        view.addSubview(loadingIndicator)
    }

    func styleViews() {
        collectionView.backgroundColor = .surface1
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(EventCell.self, forCellWithReuseIdentifier: EventCell.reuseIdentifier)
        collectionView.register(LeagueHeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: LeagueHeaderCell.reuseIdentifier)
        collectionView.register(EventSectionDividerView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: EventSectionDividerView.reuseIdentifier)

        collectionView.automaticallyAdjustsScrollIndicatorInsets = false
        let collectionViewScrollInsets = Constants.scrollInsets.bottom + view.safeAreaInsets.bottom
        collectionView.verticalScrollIndicatorInsets.bottom = collectionViewScrollInsets

        emptyStateLabel.text = .emptyStateMessage
        emptyStateLabel.textAlignment = .center
        emptyStateLabel.textColor = .surfaceLv2

        loadingIndicator.color = .surfaceLv2
        loadingIndicator.hidesWhenStopped = true
    }

    func setupConstraints() {
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        loadingIndicator.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }

    private func setupBinding() {
        viewModel.isDataFetching = { [weak self] isLoading in
            isLoading ? self?.loadingIndicator.startAnimating() : self?.loadingIndicator.stopAnimating()
            self?.collectionView.reloadData()
            self?.updateEmptyState(isLoading)
        }
    }

    private func updateEmptyState(_ isLoading: Bool) {
        collectionView.backgroundView = viewModel.leagues.isEmpty && !isLoading ? emptyStateLabel : nil
    }
}

// MARK: - UICollectionViewDataSource

extension EventsViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.leagues.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let league = viewModel.leagues[section]

        return viewModel.getEvents(for: league).count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let league = viewModel.leagues[indexPath.section]
        let eventViewModel = viewModel.getEvents(for: league)[indexPath.row]

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EventCell.reuseIdentifier, for: indexPath) as? EventCell else { return UICollectionViewCell() }

        cell.bind(eventViewModel)

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let leagueViewModel = viewModel.leagues[indexPath.section]

            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: LeagueHeaderCell.reuseIdentifier, for: indexPath) as? LeagueHeaderCell else { return UICollectionReusableView() }

            headerView.bind(leagueViewModel)

            return headerView
        }

        if kind == UICollectionView.elementKindSectionFooter {
            guard let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: EventSectionDividerView.reuseIdentifier, for: indexPath) as? EventSectionDividerView else { return UICollectionReusableView() }

            footerView.isHidden = indexPath.section == collectionView.numberOfSections - 1 ? true : false

            return footerView
        }

        return UICollectionReusableView()
    }
}

// MARK: - UICollectionViewDelegate - Selection

extension EventsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let eventDetailsVC = EventDetailsViewController()
        eventDetailsVC.delegate = self

        let league = viewModel.leagues[indexPath.section]
        let eventsViewModel = viewModel.getEvents(for: league)[indexPath.row]

        let eventDetailsViewModel = EventDetailsViewModel(event: eventsViewModel.rawEvent, selectedSport: viewModel.selectedSport)

        eventDetailsVC.configure(event: eventDetailsViewModel)
        pushViewController(to: eventDetailsVC)
    }
}

// MARK: - Navigation

extension EventsViewController {
    private func pushViewController(to viewController: UIViewController) {
        push(viewController, animated: true)
    }
}

// MARK: - NavigationBarViewDelegate

extension EventsViewController: EventDetailsViewControllerDelegate {
    func eventDetailsViewControllerDidPressBack(_ eventDetailsViewController: EventDetailsViewController) {
        pop(animated: true)
    }
}
