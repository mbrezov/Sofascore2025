//
//  EventDetailsViewController.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 08.04.2025..
//

import SnapKit
import SofaAcademic
import UIKit

class EventDetailsViewController: UIViewController, BaseViewProtocol {

    let navBar = BackNavigationBarView()
    private let navbarTitleView = EventDetailsNavbarTitleView()
    private let matchHeaderView = EventDetailsMatchHeroView()

    override func viewDidLoad() {
        super.viewDidLoad()

        addViews()
        styleViews()
        setupConstraints()
    }

    func styleViews() {
        view.backgroundColor = .surface

        navBar.configure(tintColor: .surfaceLv1, bgColor: .surface1, titleView: navbarTitleView)
    }

    func addViews() {
        view.addSubview(navBar)
        view.addSubview(matchHeaderView)
    }

    func setupConstraints() {
        navBar.constrainToTopOfSuperview()

        matchHeaderView.snp.makeConstraints {
            $0.top.equalTo(navBar.snp.bottom)
            $0.leading.trailing.equalToSuperview()
        }
    }

    func configure(event: EventDetailsViewModel, round: Int, sport: SportType?) {
        navbarTitleView.configure(logo: event.leagueLogoURL, sport: sport, country: event.country, leagueName: event.leagueName, round: round)

        matchHeaderView.viewModel = event
    }
}
