//
//  MainViewController.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 11.03.2025..
//

import SnapKit
import SofaAcademic
import UIKit

class MainViewController: UIViewController, BaseViewProtocol {

    private let eventsViewController = LeagueEventViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .surface1

        addViews()
        setupConstraints()
    }

    func addViews() {
        view.addSubview(eventsViewController.view)
    }

    func setupConstraints() {
        eventsViewController.view.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
