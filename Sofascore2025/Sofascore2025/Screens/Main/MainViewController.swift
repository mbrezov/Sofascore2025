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

    private let headerView = MainHeaderView()
    private let sportSelectorMenuView: SportSelectorMenuView
    private let eventsViewModel: EventsViewModel
    private let eventsViewController: EventsViewController

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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .surface1

        addViews()
        setupConstraints()
        setupBinding()

        sportSelectorMenuView.setupSports(with: sports, selectedSport: .football)

        headerView.delegate = self
    }

    func addViews() {
        view.addSubview(headerView)
        view.addSubview(sportSelectorMenuView)
        addChildController(eventsViewController)
    }

    func setupConstraints() {
        headerView.constrainToTopOfSuperview()

        sportSelectorMenuView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
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
            self.eventsViewController.selectedSport = sport
        }
    }
}

// MARK: - Navigation - MainHeaderViewDelegate

extension MainViewController: MainHeaderViewDelegate {
    func openSettings() {
        let settingsVC = SettingsViewController()
        settingsVC.navBar.delegate = self
        presentFullScreenModal(settingsVC, animated: true)
    }
}

// MARK: - Navigation - BackNavigationBarViewDelegate

extension MainViewController: BackNavigationBarViewDelegate {
    func goBack() {
        dismissModal(animated: true)
    }
}
