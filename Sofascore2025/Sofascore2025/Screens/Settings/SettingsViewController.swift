//
//  SettingsViewController.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 08.04.2025..
//

import SnapKit
import SofaAcademic
import UIKit

protocol SettingsViewControllerDelegate: AnyObject {

    func settingsViewControllerDidPressBack(_ settingsViewController: SettingsViewController)
}

class SettingsViewController: UIViewController, BaseViewProtocol {

    private enum Padding {

        static let horizontal: CGFloat = 16
        static let collectionViewVertical: CGFloat = 16
        static let logoutButtonBottom: CGFloat = 16
    }

    private let settingsViewModel = SettingsViewModel()

    private let navBar = NavigationBarView()
    private let collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: .settingsViewControllerCompositionalLayout()
    )
    private let logoutButton = SolidButton()

    weak var delegate: SettingsViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        addViews()
        styleViews()
        setupConstraints()
        setupBinding()

        navBar.delegate = self
    }

    func addViews() {
        view.addSubview(navBar)
        view.addSubview(collectionView)
        view.addSubview(logoutButton)
    }

    func styleViews() {
        view.backgroundColor = .surface

        navBar.backgroundColor = .primaryDefault
        navBar.tintColor = .surface1
        navBar.setTitle(.settingsTitle)

        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = false
        collectionView.dataSource = self
        collectionView.register(SettingsRowCell.self, forCellWithReuseIdentifier: SettingsRowCell.reuseIdentifier)

        logoutButton.setTitle(.logoutButtonTitle, for: .normal)
    }

    func setupConstraints() {
        navBar.snp.makeConstraints {
            $0.top.directionalHorizontalEdges.equalToSuperview()
        }

        collectionView.snp.makeConstraints {
            $0.top.equalTo(navBar.snp.bottom).offset(Padding.collectionViewVertical)
            $0.directionalHorizontalEdges.equalToSuperview().inset(Padding.horizontal)
            $0.bottom.greaterThanOrEqualTo(logoutButton.snp.top).inset(Padding.collectionViewVertical)
        }

        logoutButton.snp.makeConstraints {
            $0.directionalHorizontalEdges.equalToSuperview().inset(Padding.horizontal)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(Padding.logoutButtonBottom)
        }
    }

    func setupBinding() {
        logoutButton.addTarget(self, action: #selector(handleLogout), for: .touchUpInside)
    }

    @objc private func handleLogout() {
        settingsViewModel.logout()
    }
}

// MARK: - UICollectionViewDataSource

extension SettingsViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return settingsViewModel.rows.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: SettingsRowCell.reuseIdentifier,
            for: indexPath) as? SettingsRowCell else { return UICollectionViewCell() }

        cell.bind(settingsViewModel.rows[indexPath.row])

        return cell
    }
}

// MARK: - NavigationBarViewDelegate

extension SettingsViewController: NavigationBarViewDelegate {
    func navigationBarViewDidPressBack(_ navigationBarView: NavigationBarView) {
        delegate?.settingsViewControllerDidPressBack(self)
    }
}
