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

    private let eventsViewModel: EventsViewModel
    private let eventsViewController: EventsViewController
    private let sportSelectorMenuView: SportSelectorMenuView

    private let sports: [SportType] = [.football, .basketball, .americanFootball]

    init(eventsViewModel: EventsViewModel = EventsViewModel()) {
        self.eventsViewModel = eventsViewModel
        self.eventsViewController = EventsViewController(viewModel: eventsViewModel)
        self.sportSelectorMenuView = SportSelectorMenuView()

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
        view.addSubview(sportSelectorMenuView)
        addChildController(eventsViewController)
    }

    func setupConstraints() {
        sportSelectorMenuView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }

        eventsViewController.view.snp.makeConstraints {
            $0.top.equalTo(sportSelectorMenuView.snp.bottom)
            $0.bottom.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
    }

    func setupBinding() {
        sportSelectorMenuView.onSportSelected = { [weak self] sport in
            guard let self = self else { return }
            self.eventsViewModel.selectSport(sport)
        }

        sportSelectorMenuView.setupSports(with: sports, selectedSport: .football)
    }
}
