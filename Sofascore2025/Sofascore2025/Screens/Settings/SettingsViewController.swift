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

    private let navBar = NavigationBarView()
    weak var delegate: SettingsViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        addViews()
        styleViews()
        setupConstraints()

        navBar.delegate = self
    }

    func addViews() {
        view.addSubview(navBar)
    }

    func styleViews() {
        view.backgroundColor = .surface

        navBar.backgroundColor = .primaryDefault
        navBar.tintColor = .surface1
        navBar.setTitle(title: .settingsTitle)
    }

    func setupConstraints() {
        navBar.snp.makeConstraints {
            $0.top.directionalHorizontalEdges.equalToSuperview()
        }
    }
}

// MARK: - NavigationBarViewDelegate

extension SettingsViewController: NavigationBarViewDelegate {
    func navigationBarViewDidPressBack(_ navigationBarView: NavigationBarView) {
        delegate?.settingsViewControllerDidPressBack(self)
    }
}
