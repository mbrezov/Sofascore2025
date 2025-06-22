//
//  TeamDetailsViewController.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 20.06.2025..
//

import SnapKit
import SofaAcademic
import UIKit

protocol ChildScrollReportingProtocol: AnyObject {

    func childViewControllerDidScroll(_ scrollView: UIScrollView)
}

protocol TeamDetailsViewControllerDelegate: AnyObject {

    func teamDetailsViewControllerDidPressBack(_ teamDetailsViewController: TeamDetailsViewController)
}

class TeamDetailsViewController: UIViewController, BaseViewProtocol {

    private let navBar = NavigationBarView()
    private let headerView = LeagueDetailsHeaderView()
    private let tabSelectorMenuView = TabSelectorMenuView()
    let contentContainerView = UIView()

    private let teamDetailsViewModel: TeamDetailsViewModel
    private var currentChildVC: UIViewController?

    weak var delegate: TeamDetailsViewControllerDelegate?

    private var headerBottomConstraint: Constraint?
    private var initialHeaderHeight: CGFloat = 0

    private lazy var infoViewController: InfoViewController? = {
        let vm = teamDetailsViewModel.makeInfoViewModel()
        let vc = InfoViewController(viewModel: vm)
        vc.scrollDelegate = self
        return vc
    }()

    private lazy var squadViewController: SquadViewController? = {
        let vm = teamDetailsViewModel.makeSquadViewModel()
        let vc = SquadViewController(viewModel: vm)
        vc.scrollDelegate = self
        return vc
    }()

    init(_ teamDetailsViewModel: TeamDetailsViewModel) {
        self.teamDetailsViewModel = teamDetailsViewModel
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
            teamDetailsViewModel.name,
            teamDetailsViewModel.countryName,
            teamDetailsViewModel.logoURL
        )
    }

    func addViews() {
        view.addSubview(navBar)
        view.addSubview(headerView)
        view.addSubview(tabSelectorMenuView)
        view.addSubview(contentContainerView)
    }

    func styleViews() {
        navBar.backgroundColor = .primaryDefault
        navBar.tintColor = .surface1
        navBar.setTitle(teamDetailsViewModel.name)
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

extension TeamDetailsViewController: TabSelectorMenuViewSwitchProtocol {
    var tabs: [TabItem] {
        [
            TabItem(title: .teamDetailsTabTitle, index: 0),
            TabItem(title: .teamSquadTabTitle, index: 1)
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
        [infoViewController, squadViewController]
    }
}

// MARK: - ChildScrollReportingProtocol

extension TeamDetailsViewController: ChildScrollReportingProtocol {
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

// MARK: - NavigationBarViewDelegate

extension TeamDetailsViewController: NavigationBarViewDelegate {
    func navigationBarViewDidPressBack(_ navigationBarView: NavigationBarView) {
        delegate?.teamDetailsViewControllerDidPressBack(self)
    }
}
