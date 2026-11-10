//
//  SquadCollectionViewController.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 20.06.2025..
//

import SnapKit
import SofaAcademic
import UIKit

class SquadViewController: UIViewController, BaseViewProtocol {

    private enum Constants {

        static let contentInset: CGFloat = 40
        static let scrollInsets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: Constants.contentInset, right: 0)
    }

    private let viewModel: SquadViewModel
    weak var scrollDelegate: ChildScrollReportingProtocol?

    private let collectionView: UICollectionView
    private let emptyStateLabel = UILabel()

    var isSquadEmpty: Bool {
        viewModel.players.isEmpty
    }

    init(viewModel: SquadViewModel) {
        self.viewModel = viewModel
        let layout = UICollectionViewCompositionalLayout.teamDetailsSquadCompositionalLayout()
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

        collectionView.register(PlayerCell.self, forCellWithReuseIdentifier: PlayerCell.reuseIdentifier)
        collectionView.register(
            SquadHeaderReusableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: SquadHeaderReusableView.reuseIdentifier
        )
        collectionView.register(
            SectionDividerView.self,
            forSupplementaryViewOfKind: SectionDividerView.reuseIdentifier,
            withReuseIdentifier: SectionDividerView.reuseIdentifier
        )

        collectionView.automaticallyAdjustsScrollIndicatorInsets = false
        collectionView.verticalScrollIndicatorInsets.bottom = Constants.scrollInsets.bottom + view.safeAreaInsets.bottom
        collectionView.bounces = false
        collectionView.contentInset.bottom = Constants.contentInset

        addViews()
        setupConstraints()
        setupEmptyStateLabel()
    }

    func addViews() {
        view.addSubview(collectionView)
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
        collectionView.backgroundView?.isHidden = !isSquadEmpty
    }
}

extension SquadViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return isSquadEmpty ? 0 : 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.players.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let player = viewModel.players[indexPath.row]
        let playerCellViewModel = viewModel.makePlayerCellViewModel(for: player)

        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: PlayerCell.reuseIdentifier,
            for: indexPath
        ) as? PlayerCell else {
            return UICollectionViewCell()
        }

        cell.bind(playerCellViewModel)
        return cell
    }

    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: SquadHeaderReusableView.reuseIdentifier,
                for: indexPath
            ) as? SquadHeaderReusableView else {
                return UICollectionReusableView()
            }
            header.bind(title: .squadTitle)
            return header

        case SectionDividerView.reuseIdentifier:
            let dividerView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: SectionDividerView.reuseIdentifier,
                for: indexPath
            )

            let isLastItem = indexPath.row == collectionView.numberOfItems(inSection: indexPath.section) - 1
            dividerView.isHidden = isLastItem
            return dividerView

        default:
            return UICollectionReusableView()
        }
    }
}

// MARK: - ChildScrollReportingProtocol

extension SquadViewController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollDelegate?.childViewControllerDidScroll(scrollView)
    }
}

// MARK: - ScrollableContentControllerProtocol

extension SquadViewController: ScrollableContentControllerProtocol {
    var scrollableView: UIScrollView? {
        return collectionView
    }
}
