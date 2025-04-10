//
//  SettingsViewController.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 08.04.2025..
//

import SnapKit
import SofaAcademic
import UIKit

class SettingsViewController: UIViewController, BaseViewProtocol {

    let navBar = BackNavigationBarView()

    override func viewDidLoad() {
        super.viewDidLoad()

        addViews()
        styleViews()
        setupConstraints()
    }

    func addViews() {
        view.addSubview(navBar)
    }

    func styleViews() {
        view.backgroundColor = .surface

        navBar.configure(bgColor: .primaryDefault, title: .settingsTitle)
    }

    func setupConstraints() {
        navBar.constrainToTopOfSuperview()
    }
}
