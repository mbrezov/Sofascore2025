//
//  LeagueEventViewController.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 12.03.2025..
//

import SnapKit
import SofaAcademic
import UIKit

class LeagueEventViewController: UIViewController, BaseViewProtocol {

    private let data = Homework2DataSource()

    private let leagueHeaderView = LeagueHeaderView()
    private let eventsStackView = UIStackView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .surface1

        let leagueViewModel = LeagueViewModel(league: data.laLigaLeague())
        leagueHeaderView.setupBinding(with: leagueViewModel)

        for event in data.laLigaEvents() {
            let leagueEventView = LeagueEventView()
            let eventViewModel = EventViewModel(event: event)
            leagueEventView.setupBinding(with: eventViewModel)
            eventsStackView.addArrangedSubview(leagueEventView)
        }

        addViews()
        styleViews()
        setupConstraints()
    }

    func addViews() {
        view.addSubview(leagueHeaderView)
        view.addSubview(eventsStackView)
    }

    func styleViews() {
        eventsStackView.axis = .vertical
        eventsStackView.distribution = .equalSpacing
    }

    func setupConstraints() {
        leagueHeaderView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview()
        }

        eventsStackView.snp.makeConstraints {
            $0.top.equalTo(leagueHeaderView.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
        }
    }
}
