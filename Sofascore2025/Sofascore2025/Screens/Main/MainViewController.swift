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

    private let viewModel: EventsViewModel
    private let eventsViewController: EventsViewController
    private let sportSelectorMenuViewController: SportSelectorMenuViewController

    init(viewModel: EventsViewModel = EventsViewModel()) {
        self.viewModel = viewModel
        self.eventsViewController = EventsViewController(viewModel: viewModel)
        self.sportSelectorMenuViewController = SportSelectorMenuViewController()

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .surface1

        addViews()
        setupConstraints()
        setupBinding()
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

    func setupBinding() {
        sportSelectorMenuViewController.onSportSelected = { [weak self] sport in
            guard let self = self else { return }
            self.viewModel.selectSport(sport)
        }
    }
}
