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

    private let viewModel = EventsViewModel()

    private lazy var eventsViewController = EventsViewController(viewModel: viewModel)
    private lazy var sportSelectorMenuViewController = SportSelectorMenuViewController(viewModel: viewModel)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .surface1

        addViews()
        setupConstraints()
    }

    func addViews() {
        addChildController(eventsViewController)
        addChildController(sportSelectorMenuViewController)
    }

    func setupConstraints() {
        sportSelectorMenuViewController.view.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }

        eventsViewController.view.snp.makeConstraints {
            $0.top.equalTo(sportSelectorMenuViewController.view.snp.bottom)
            $0.bottom.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
