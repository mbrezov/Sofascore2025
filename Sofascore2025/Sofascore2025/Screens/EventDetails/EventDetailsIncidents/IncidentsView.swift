//
//  IncidentsView.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 24.05.2025..
//

import SnapKit
import SofaAcademic
import UIKit

class IncidentsView: BaseView {

    private enum Padding {

        static let noIncidentsViewTop: CGFloat = 8
    }

    private enum Constants {

        static let contentInset: UIEdgeInsets = UIEdgeInsets(
            top: 8,
            left: 0,
            bottom: 48,
            right: 0
        )
        static let scrollInsets: UIEdgeInsets = UIEdgeInsets(
            top: 0,
            left: 0,
            bottom: Constants.contentInset.bottom,
            right: 0
        )
    }

    private var incidents: [Incident]?
    private var incidentsViewModel: IncidentsViewModel?

    private let noIncidentsView = EventDetailsIncidentsEmptyStateView()
    private let collectionView =  UICollectionView(
        frame: .zero,
        collectionViewLayout: .eventDetailsIncidentsCompositionalLayout()
    )
    private let loadingIndicator = UIActivityIndicatorView(style: .medium)

    override func addViews() {
        addSubview(loadingIndicator)
    }

    override func styleViews() {
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.register(
            IncidentsCell.self,
            forCellWithReuseIdentifier: IncidentsCell.reuseIdentifier
        )
        collectionView.automaticallyAdjustsScrollIndicatorInsets = false
        collectionView.verticalScrollIndicatorInsets.bottom = Constants.scrollInsets.bottom + safeAreaInsets.bottom
        collectionView.bounces = false
        collectionView.contentInset = Constants.contentInset

        loadingIndicator.color = .surfaceLv2
        loadingIndicator.hidesWhenStopped = true
    }

    override func setupConstraints() {
        loadingIndicator.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }

    private func setupNoIncidentsView() {
        addSubview(noIncidentsView)

        noIncidentsView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Padding.noIncidentsViewTop)
            $0.directionalHorizontalEdges.equalToSuperview()
        }
    }

    private func setupIncidentsCollectionView() {
        addSubview(collectionView)

        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    func configure(with viewModel: IncidentsViewModel) {
        self.incidentsViewModel = viewModel
        viewModel.onIncidentsUpdated = { [weak self] in
            self?.incidents = viewModel.visibleIncidents
            viewModel.isDataFetching = { [weak self] isLoading in
                self?.collectionView.isHidden = isLoading
                if isLoading {
                    self?.loadingIndicator.startAnimating()
                } else {
                    self?.loadingIndicator.stopAnimating()
                }
            }

            if self?.incidents?.isEmpty == true {
                self?.setupNoIncidentsView()
            } else {
                self?.collectionView.reloadData()
                self?.setupIncidentsCollectionView()
            }
        }
    }
}

extension IncidentsView: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        incidents?.count ?? 0
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: IncidentsCell.reuseIdentifier,
            for: indexPath
        ) as? IncidentsCell else { return UICollectionViewCell() }
        guard let viewModel = incidentsViewModel else { return cell }
        guard let incident = viewModel.makeIncidentCellViewModel(
            for: viewModel.visibleIncidents[indexPath.row]
        ) else { return cell }

        cell.bind(incident)
        return cell
    }
}
