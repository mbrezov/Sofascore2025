//
//  EventDetailsViewController.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 08.04.2025..
//

import SnapKit
import SofaAcademic
import UIKit

protocol EventDetailsViewControllerDelegate: AnyObject {

    func eventDetailsViewControllerDidPressBack(_ eventDetailsViewController: EventDetailsViewController)
}

class EventDetailsViewController: UIViewController, BaseViewProtocol {

    private let navBar = NavigationBarView()
    private let navBarTitleView = EventDetailsNavBarTitleView()
    private let matchHeaderView = EventDetailsMatchHeroView()
    private let eventDetailsViewModel: EventDetailsViewModel

    weak var delegate: EventDetailsViewControllerDelegate?

    init(_ eventDetailsViewModel: EventDetailsViewModel) {
        self.eventDetailsViewModel = eventDetailsViewModel
        super.init(nibName: nil, bundle: nil)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        addViews()
        styleViews()
        setupConstraints()

        navBar.delegate = self
    }

    func styleViews() {
        view.backgroundColor = .surface

        navBar.backgroundColor = .surface1
        navBar.tintColor = .surfaceLv1
        navBar.setTitleView(navBarTitleView)
    }

    func addViews() {
        view.addSubview(navBar)
        view.addSubview(matchHeaderView)
    }

    func setupConstraints() {
        navBar.snp.makeConstraints {
            $0.top.directionalHorizontalEdges.equalToSuperview()
        }

        matchHeaderView.snp.makeConstraints {
            $0.top.equalTo(navBar.snp.bottom)
            $0.directionalHorizontalEdges.equalToSuperview()
        }
    }

    private func setupUI() {
        navBarTitleView.configure(
            imageURL: eventDetailsViewModel.leagueLogoURL,
            title: eventDetailsViewModel.leagueDescription
        )

        matchHeaderView.configure(
            homeTeamInfo: eventDetailsViewModel.homeTeamInfo,
            awayTeamInfo: eventDetailsViewModel.awayTeamInfo,
            isStarted: eventDetailsViewModel.isStarted,
            dateText: eventDetailsViewModel.dateText,
            startTimeText: eventDetailsViewModel.startTimeText,
            statusText: eventDetailsViewModel.statusInfo.description,
            statusColor: eventDetailsViewModel.statusInfo.color.uiColor
        )
    }
}

// MARK: - NavigationBarViewDelegate

extension EventDetailsViewController: NavigationBarViewDelegate {
    func navigationBarViewDidPressBack(_ navigationBarView: NavigationBarView) {
        delegate?.eventDetailsViewControllerDidPressBack(self)
    }
}
