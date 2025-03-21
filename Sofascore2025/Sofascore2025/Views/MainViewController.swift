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

    private let eventsViewController = EventsViewController()
    private let sportSelectorMenuViewController = SportSelectorMenuViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .surface1

        addViews()
        setupConstraints()
    }

    func addViews() {
        addChild(eventsViewController)
        view.addSubview(eventsViewController.view)
        eventsViewController.didMove(toParent: self)

        addChild(sportSelectorMenuViewController)
        view.addSubview(sportSelectorMenuViewController.view)
        sportSelectorMenuViewController.didMove(toParent: self)
    }

    func setupConstraints() {
        sportSelectorMenuViewController.view.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }

        eventsViewController.view.snp.makeConstraints {
            $0.top.equalTo(sportSelectorMenuViewController.view.snp.bottom)
            $0.bottom.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
