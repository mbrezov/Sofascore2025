//
//  LeagueDetailsViewController.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 05.06.2025..
//

import SnapKit
import SofaAcademic
import UIKit

protocol LeagueDetailsViewControllerDelegate: AnyObject {

    func leagueDetailsViewControllerDidPressBack(_ leagueDetailsViewController: LeagueDetailsViewController)
}

class LeagueDetailsViewController: UIViewController, BaseViewProtocol, UIScrollViewDelegate, UICollectionViewDelegate {

    private let navBar = NavigationBarView()
    private let headerView = LeagueDetailsHeaderView()
    private let tabSelectorMenuView = TabSelectorMenuView()
    let contentContainerView = UIView()

    let leagueDetailsViewModel: LeagueDetailsViewModel
    private var currentChildVC: UIViewController?

    weak var delegate: LeagueDetailsViewControllerDelegate?

    private var headerBottomConstraint: Constraint?
    private var initialHeaderHeight: CGFloat = 0

    lazy var matchesViewController: MatchesViewController? = {
        guard let vm = leagueDetailsViewModel.makeMatchesViewModel() else { return nil }
        let vc = MatchesViewController(viewModel: vm)
        vc.scrollDelegate = self
        return vc
    }()

    lazy var standingsViewController: StandingsViewController? = {
        guard let vm = leagueDetailsViewModel.makeStandingsViewModel() else { return nil }
        let vc = StandingsViewController(viewModel: vm)
        vc.scrollDelegate = self
        return vc
    }()

    init(_ leagueDetailsViewModel: LeagueDetailsViewModel) {
        self.leagueDetailsViewModel = leagueDetailsViewModel
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
        setupBinding()

        navBar.delegate = self
        tabSelectorMenuView.setupTabs(with: tabs, selectedTab: tabs[0])
        switchToTab(tabs[0])

        view.layoutIfNeeded()
        initialHeaderHeight = headerView.bounds.height
    }

    func setupUI() {
        headerView.configure(
            leagueDetailsViewModel.name,
            leagueDetailsViewModel.countryName,
            leagueDetailsViewModel.logoURL
        )
    }

    func addViews() {
        view.addSubview(navBar)
        view.addSubview(headerView)
        view.addSubview(tabSelectorMenuView)
        view.addSubview(contentContainerView)
    }

    func styleViews() {
        view.backgroundColor = .surface

        navBar.backgroundColor = .primaryDefault
        navBar.tintColor = .surface1
        navBar.setTitle(leagueDetailsViewModel.name)
        navBar.titleOpacity = 0
    }

    func setupConstraints() {
        navBar.snp.makeConstraints {
            $0.top.directionalHorizontalEdges.equalToSuperview()
        }

        headerView.snp.makeConstraints {
            $0.top.equalTo(navBar.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            headerBottomConstraint = $0.bottom.equalTo(
                tabSelectorMenuView.snp.top
            ).offset(initialHeaderHeight).constraint
        }

        tabSelectorMenuView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom)
            $0.directionalHorizontalEdges.equalToSuperview()
        }

        contentContainerView.snp.makeConstraints {
            $0.top.equalTo(tabSelectorMenuView.snp.bottom)
            $0.directionalHorizontalEdges.bottom.equalToSuperview()
        }
    }

    func setupBinding() {
        tabSelectorMenuView.onTabSelected = { [weak self] tab in
            self?.switchToTab(tab)
        }
    }
}

// MARK: - TabSelectorMenuViewSwitchProtocol

extension LeagueDetailsViewController: TabSelectorMenuViewSwitchProtocol {
    var tabs: [TabItem] {
        [
            TabItem(title: .leagueMatchesTabTitle, index: 0),
            TabItem(title: .leagueStandingsTabTitle, index: 1)
        ]
    }

    var containerView: UIView {
        contentContainerView
    }

    var currentChildViewController: UIViewController? {
        get { self.currentChildVC }
        set { self.currentChildVC = newValue }
    }

    var tabViewControllers: [UIViewController?] {
        [matchesViewController, standingsViewController]
    }
}

// MARK: - NavigationBarViewDelegate

extension LeagueDetailsViewController: NavigationBarViewDelegate {
    func navigationBarViewDidPressBack(_ navigationBarView: NavigationBarView) {
        delegate?.leagueDetailsViewControllerDidPressBack(self)
    }
}

// MARK: ChildScrollReportingProtocol

extension LeagueDetailsViewController: ChildScrollReportingProtocol {
    func childViewControllerDidScroll(_ scrollView: UIScrollView) {
        let thresHold: CGFloat = 80
        let rawOffsetY = scrollView.contentOffset.y + scrollView.adjustedContentInset.top
        let offsetY = max(0, rawOffsetY - thresHold)
        let clampedOffset = min(initialHeaderHeight, offsetY)

        headerBottomConstraint?.update(offset: clampedOffset)

        let collapseProgress = min(1, clampedOffset / initialHeaderHeight)
        let headerCollapseProgress = 1 - collapseProgress

        navBar.titleOpacity = collapseProgress
        headerView.logoImageOpacity = headerCollapseProgress
        headerView.nameContainerOpacity = headerCollapseProgress
    }
}
