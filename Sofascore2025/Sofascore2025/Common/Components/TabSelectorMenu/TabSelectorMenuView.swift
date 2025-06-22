//
//  TabSelectorMenuView.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 08.06.2025..
//

import SnapKit
import SofaAcademic
import UIKit

protocol ScrollableContentControllerProtocol {

    var scrollableView: UIScrollView? { get }
}

protocol TabSelectorMenuViewSwitchProtocol: AnyObject {

    var tabs: [TabItem] { get }
    var containerView: UIView { get }
    var currentChildViewController: UIViewController? { get set }
    var tabViewControllers: [UIViewController?] { get }
}

struct TabItem: Hashable {

    let title: String
    let index: Int
}

class TabSelectorMenuView: BaseView {

    private enum Constants {

        static let cornerRadius: CGFloat = 2
        static let selectionViewHeight: CGFloat = 4
        static let selectionViewHorizontalInset: CGFloat = 8
        static let shadowHeight: CGFloat = 4
    }

    private let stackView = UIStackView()
    private let selectionView = UIView()

    private var tabViews: [TabItem: TabSelectorMenuItemView] = [:]

    var onTabSelected: ((TabItem) -> Void)?

    private var selectedIndex: TabItem?

    private var selectedSegment: TabSelectorMenuItemView? {
        if let index = selectedIndex {
            return tabViews[index]
        }
        return nil
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        applyBottomShadow()
    }

    override func addViews() {
        addSubview(stackView)
        addSubview(selectionView)
    }

    override func styleViews() {
        backgroundColor = .primaryDefault
        layer.zPosition = 1

        stackView.axis = .horizontal
        stackView.distribution = .fillEqually

        selectionView.backgroundColor = .surface1
        selectionView.layer.cornerRadius = Constants.cornerRadius
        selectionView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }

    override func setupConstraints() {
        stackView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.directionalHorizontalEdges.bottom.equalToSuperview()
        }
    }

    func setupTabs(with tabs: [TabItem], selectedTab: TabItem) {
        for tabView in stackView.arrangedSubviews {
            stackView.removeArrangedSubview(tabView)
            tabView.removeFromSuperview()
        }

        tabs.forEach { tab in
            let tabView = TabSelectorMenuItemView()
            tabView.setup(name: tab.title)
            tabView.onTap = { [weak self] in
                self?.selectedIndex = tab
                self?.updateSelection(animated: true)
                self?.onTabSelected?(tab)
            }
            tabViews[tab] = tabView
            stackView.addArrangedSubview(tabView)
        }

        selectedIndex = selectedTab
        updateSelection(animated: false)
        onTabSelected?(selectedTab)
    }

    private func updateSelectionViewConstraints(for selectedSegment: TabSelectorMenuItemView) {
        selectionView.snp.remakeConstraints {
            $0.height.equalTo(Constants.selectionViewHeight)
            $0.bottom.equalTo(stackView.snp.bottom)
            $0.directionalHorizontalEdges.equalTo(selectedSegment).inset(Constants.selectionViewHorizontalInset)
        }
    }

    private func updateSelection(animated: Bool) {
        guard let selectedSegment = selectedSegment else { return }

        if animated {
            UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseInOut], animations: { [weak self] in
                guard let self = self else { return }
                self.updateSelectionViewConstraints(for: selectedSegment)
                self.layoutIfNeeded()
            })
        } else {
            updateSelectionViewConstraints(for: selectedSegment)
            layoutIfNeeded()
        }
    }

    private func applyBottomShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowOffset = .zero
        layer.shadowRadius = 8
        layer.masksToBounds = false

        let shadowRect = CGRect(
            x: 0,
            y: bounds.height - Constants.shadowHeight,
            width: bounds.width,
            height: Constants.shadowHeight
        )
        layer.shadowPath = UIBezierPath(rect: shadowRect).cgPath
    }
}

// MARK: - TabSelectorMenuViewSwitchProtocol - switchToTab method

extension TabSelectorMenuViewSwitchProtocol where Self: UIViewController {
    func switchToTab(_ tab: TabItem) {
        if let current = currentChildViewController {
            removeChildController(current)
        }

        let newVC = tab.index < tabViewControllers.count ? tabViewControllers[tab.index] : nil
        if let vc = newVC {
            addCustomViewChildController(containerView, vc)
            vc.view.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
            DispatchQueue.main.async {
                if let scrollVC = vc as? UIViewController & ScrollableContentControllerProtocol,
                   let scrollView = scrollVC.scrollableView,
                   let reportingVC = self as? ChildScrollReportingProtocol {
                    scrollView.setContentOffset(
                        CGPoint(x: 0, y: -scrollView.adjustedContentInset.top),
                        animated: false
                    )
                    scrollView.layoutIfNeeded()
                    reportingVC.childViewControllerDidScroll(scrollView)
                }
            }
        }
        currentChildViewController = newVC
    }
}
