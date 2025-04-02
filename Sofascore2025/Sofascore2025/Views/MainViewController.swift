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

    private let viewModel: MainViewModelProtocol
    private let eventsViewController: EventsViewController
    private let sportSelectorMenuViewController: SportSelectorMenuViewController

    init(viewModel: MainViewModel = MainViewModel()) {
        self.viewModel = viewModel
        self.eventsViewController = EventsViewController(viewModel: viewModel.eventsViewModel)
        self.sportSelectorMenuViewController = SportSelectorMenuViewController()

        super.init(nibName: nil, bundle: nil)

        sportSelectorMenuViewController.onSportSelected = { [weak self] sport in
            guard let self = self else { return }
            self.viewModel.selectSport(sport)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

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
