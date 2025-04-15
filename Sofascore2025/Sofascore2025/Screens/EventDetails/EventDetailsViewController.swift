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

    weak var delegate: EventDetailsViewControllerDelegate?

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
        navBar.setTitleView(with: navBarTitleView)
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

    func configure(event: EventDetailsViewModel) {
        navBarTitleView.configure(logo: event.leagueLogoURL, sport: event.selectedSportText, country: event.country, leagueName: event.leagueName, roundText: event.roundText)

        matchHeaderView.configure(homeTeamInfo: event.homeTeamInfo, awayTeamInfo: event.awayTeamInfo, isStarted: event.isNotStarted, dateText: event.dateText, startTimeText: event.startTimeText, statusText: event.statusInfo.description, statusColor: event.statusInfo.color.uiColor)
    }
}

// MARK: - NavigationBarViewDelegate

extension EventDetailsViewController: NavigationBarViewDelegate {
    func navigationBarViewDidPressBack(_ navigationBarView: NavigationBarView) {
        delegate?.eventDetailsViewControllerDidPressBack(self)
    }
}
