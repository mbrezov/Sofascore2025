//
//  InfoCollectionViewController.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 20.06.2025..
//

import SnapKit
import SofaAcademic
import UIKit

class InfoViewController: UIViewController, BaseViewProtocol {

    private enum Constants {

        static let contentInset: CGFloat = 48
        static let scrollInsets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: Constants.contentInset, right: 0)
    }

    private let viewModel: InfoViewModel
    weak var scrollDelegate: ChildScrollReportingProtocol?

    private let collectionView: UICollectionView
    private let emptyStateLabel = UILabel()
    private let loadingIndicator = UIActivityIndicatorView(style: .medium)
    private let loadingContainerView = UIView()

    var isInfoEmpty: Bool {
        viewModel.tournaments.isEmpty && viewModel.details == nil
    }

    init(viewModel: InfoViewModel) {
        self.viewModel = viewModel
        let layout = UICollectionViewCompositionalLayout.teamDetailsInfoCompositionalLayout(viewModel: viewModel)
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .surface
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self

        collectionView.register(InfoCell.self, forCellWithReuseIdentifier: InfoCell.reuseIdentifier)
        collectionView.register(TournamentsCell.self, forCellWithReuseIdentifier: TournamentsCell.reuseIdentifier)
        collectionView.register(VenueCell.self, forCellWithReuseIdentifier: VenueCell.reuseIdentifier)
        collectionView.register(
            InfoHeaderReusableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: InfoHeaderReusableView.reuseIdentifier
        )
        collectionView.register(
            SectionDividerView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
            withReuseIdentifier: SectionDividerView.reuseIdentifier
        )

        collectionView.automaticallyAdjustsScrollIndicatorInsets = false
        collectionView.verticalScrollIndicatorInsets.bottom = Constants.scrollInsets.bottom + view.safeAreaInsets.bottom
        collectionView.bounces = false
        collectionView.contentInset.bottom = Constants.contentInset

        addViews()
        setupConstraints()
        setupBinding()
        setupLoadingIndicator()
        setupEmptyStateLabel()
    }

    func addViews() {
        view.addSubview(collectionView)
        view.addSubview(loadingContainerView)
    }

    func setupConstraints() {
        collectionView.snp.makeConstraints {
            $0.top.directionalHorizontalEdges.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        loadingContainerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    private func setupEmptyStateLabel() {
        collectionView.backgroundView = emptyStateLabel
        emptyStateLabel.text = .teamInfoEmptyStateMessage
        emptyStateLabel.textAlignment = .center
        emptyStateLabel.textColor = .surfaceLv2
    }

    private func setupLoadingIndicator() {
        loadingContainerView.backgroundColor = .surface
        loadingContainerView.addSubview(loadingIndicator)
        loadingIndicator.snp.makeConstraints { $0.center.equalToSuperview() }
        loadingIndicator.startAnimating()
    }

    private func updateEmptyState() {
        collectionView.backgroundView?.isHidden = !isInfoEmpty
    }

    private func setupBinding() {
        viewModel.onInfoUpdated = { [weak self] in
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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateEmptyState()
    }
}

extension InfoViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return isInfoEmpty ? 0 : viewModel.sectionTitles.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let infoCellViewModel = viewModel.makeInfoCellViewModel()
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: InfoCell.reuseIdentifier,
                for: indexPath
            ) as? InfoCell else {
                return UICollectionViewCell()
            }
            if let infoCellViewModel = infoCellViewModel {
                cell.bind(infoCellViewModel)
            }
            return cell

        case 1:
            let tournaments = viewModel.tournaments
            let tournamentCellViewModel = viewModel.makeTournamentsCellViewModel(
                for: tournaments,
                tournamentsCount: tournaments.count
            )
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: TournamentsCell.reuseIdentifier,
                for: indexPath
            ) as? TournamentsCell else {
                return UICollectionViewCell()
            }
            cell.bind(tournamentCellViewModel)
            return cell

        case 2:
            let venueCellViewModel = viewModel.makeVenueCellViewModel()
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: VenueCell.reuseIdentifier,
                for: indexPath
            ) as? VenueCell else {
                return UICollectionViewCell()
            }
            if let venueCellViewModel = venueCellViewModel {
                cell.bind(venueCellViewModel)
            }
            return cell
        default:
            fatalError("Unexpected section \(indexPath.section)")
        }
    }

    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let headerTitle = viewModel.sectionTitles[indexPath.section]
            guard let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: InfoHeaderReusableView.reuseIdentifier,
                for: indexPath
            ) as? InfoHeaderReusableView else {
                return UICollectionReusableView()
            }

            header.bind(headerTitle)
            return header

        case UICollectionView.elementKindSectionFooter:
            guard let footerView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: SectionDividerView.reuseIdentifier,
                for: indexPath
            ) as? SectionDividerView else {
                return UICollectionReusableView()
            }

            footerView.isHidden = indexPath.section == collectionView.numberOfSections - 1
            return footerView

        default:
            return UICollectionReusableView()
        }
    }
}

// MARK: - ChildScrollReportingProtocol

extension InfoViewController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollDelegate?.childViewControllerDidScroll(scrollView)
    }
}

// MARK: - ScrollableContentControllerProtocol

extension InfoViewController: ScrollableContentControllerProtocol {
    var scrollableView: UIScrollView? {
        return collectionView
    }
}
