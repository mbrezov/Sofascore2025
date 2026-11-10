//
//  MatchesCollectionViewController.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 05.06.2025..
//

import SnapKit
import SofaAcademic
import UIKit

class MatchesViewController: UIViewController, BaseViewProtocol {

    private enum Constants {

        static let contentInset: CGFloat = 48
        static let scrollInsets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: Constants.contentInset, right: 0)
    }
    private let viewModel: MatchesViewModel
    weak var scrollDelegate: ChildScrollReportingProtocol?

    private let collectionView: UICollectionView
    private let emptyStateLabel = UILabel()
    private let loadingIndicator = UIActivityIndicatorView(style: .medium)
    private let loadingContainerView = UIView()

    var hasNoMatches: Bool {
        viewModel.leagueMatches.isEmpty
    }

    init(viewModel: MatchesViewModel) {
        self.viewModel = viewModel

        let layout = UICollectionViewCompositionalLayout.leagueDetailsMatchesCompositionalLayout()
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.backgroundColor = .surface
        collectionView.dataSource = self
        collectionView.delegate = self

        collectionView.register(
            MatchesCell.self,
            forCellWithReuseIdentifier: MatchesCell.reuseIdentifier
        )
        collectionView.register(
            MatchesHeaderReusableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: MatchesHeaderReusableView.reuseIdentifier
        )

        collectionView.automaticallyAdjustsScrollIndicatorInsets = false
        collectionView.verticalScrollIndicatorInsets.bottom = Constants.scrollInsets.bottom + view.safeAreaInsets.bottom
        collectionView.bounces = false
        collectionView.contentInset.bottom = Constants.contentInset

        addViews()
        setupConstraints()
        setupBinding()
    }

    func addViews() {
        view.addSubview(collectionView)
        setupLoadingIndicator()
        setupEmptyStateLabel()
    }

    func setupConstraints() {
        collectionView.snp.makeConstraints {
            $0.top.directionalHorizontalEdges.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }

    private func setupLoadingIndicator() {
        loadingContainerView.backgroundColor = .surface
        view.addSubview(loadingContainerView)
        loadingContainerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        loadingContainerView.addSubview(loadingIndicator)
        loadingIndicator.snp.makeConstraints {
            $0.center.equalToSuperview()
        }

        loadingIndicator.startAnimating()
    }

    private func setupEmptyStateLabel() {
        collectionView.backgroundView = emptyStateLabel
        emptyStateLabel.text = .teamInfoEmptyStateMessage
        emptyStateLabel.textAlignment = .center
        emptyStateLabel.textColor = .surfaceLv2
    }

    private func setupBinding() {
        viewModel.onLeagueMatchesUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
                self?.updateEmptyState()
            }
        }

        viewModel.isDataFetching = { [weak self] isLoading in
            guard let self = self else { return }
            DispatchQueue.main.async {
                if !isLoading {
                    self.loadingIndicator.stopAnimating()
                    self.loadingContainerView.isHidden = true
                }
            }
        }

        viewModel.toastErrorAlert = { [weak self] title, message in
            self?.showAlert(title: title, message: message)
        }
    }

    private func updateEmptyState() {
        collectionView.backgroundView?.isHidden = !hasNoMatches
    }
}

extension MatchesViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        viewModel.rounds.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let round = viewModel.rounds[section]
        return viewModel.events(for: round).count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let event = viewModel.events(for: viewModel.rounds[indexPath.section])[indexPath.item]
        let matchesCellViewModel = MatchesCellViewModel(event: event)

        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MatchesCell.reuseIdentifier,
            for: indexPath
        ) as? MatchesCell else {
            return UICollectionViewCell()
        }

        cell.bind(matchesCellViewModel)
        return cell
    }

    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let round = viewModel.rounds[indexPath.section]
            let roundText = String.roundText(round)

            guard let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: MatchesHeaderReusableView.reuseIdentifier,
                for: indexPath
            ) as? MatchesHeaderReusableView else {
                return UICollectionReusableView()
            }

            header.bind(roundText)
            return header

        default:
            return UICollectionReusableView()
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let event = viewModel.events(for: viewModel.rounds[indexPath.section])[indexPath.item]

        guard let eventDetailsViewModel = viewModel.makeEventDetailsViewModel(for: event)
        else { return }

        let eventDetailsVC = EventDetailsViewController(eventDetailsViewModel)
        eventDetailsVC.delegate = self
        push(eventDetailsVC, animated: true)
    }
}

// MARK: - ChildScrollReportingProtocol

extension MatchesViewController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollDelegate?.childViewControllerDidScroll(scrollView)
    }
}

// MARK: - EventDetailsViewControllerDelegate

extension MatchesViewController: EventDetailsViewControllerDelegate {
    func eventDetailsViewControllerDidPressBack(_ eventDetailsViewController: EventDetailsViewController) {
        pop(animated: true)
    }
}

// MARK: - ScrollableContentControllerProtocol

extension MatchesViewController: ScrollableContentControllerProtocol {
    var scrollableView: UIScrollView? {
        collectionView
    }
}
