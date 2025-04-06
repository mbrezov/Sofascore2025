//
//  SportSelectorMenuView.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 18.03.2025..
//

import SnapKit
import SofaAcademic
import UIKit

class SportSelectorMenuView: BaseView {

    private enum Constants {

        static let cornerRadius: CGFloat = 2
        static let selectionViewHeight: CGFloat = 4
        static let selectionViewHorizontalInset: CGFloat = 8
    }

    private let stackView = UIStackView()
    private let selectionView = UIView()

    private var sportViews: [SportType: SportSelectorMenuItemView] = [:]

    var onSportSelected: ((SportType) -> Void)?

    private var selectedIndex: SportType = .football {
        didSet {
            updateSelection()
        }
    }

    private var selectedSegment: SportSelectorMenuItemView {
        sportViews[selectedIndex] ?? SportSelectorMenuItemView()
    }

    override func addViews() {
        addSubview(stackView)
        addSubview(selectionView)
    }

    override func didMoveToWindow() {
        super.didMoveToWindow()

        guard window != nil else { return }

        self.updateSelectionViewConstraints(for: selectedSegment)
        self.onSportSelected?(self.selectedIndex)
    }

    override func styleViews() {
        backgroundColor = .primaryDefault

        stackView.axis = .horizontal
        stackView.distribution = .fillEqually

        selectionView.backgroundColor = .surface1
        selectionView.layer.cornerRadius = Constants.cornerRadius
        selectionView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }

    override func setupConstraints() {
        stackView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }

    func setupSports(with sports: [SportType]) {
        for sportView in stackView.arrangedSubviews {
            stackView.removeArrangedSubview(sportView)
            sportView.removeFromSuperview()
        }

        sports.forEach { sport in
            let sportView = SportSelectorMenuItemView()
            sportView.setup(name: sport.name, image: sport.icon)
            sportView.onTap = { [weak self] in
                self?.selectedIndex = sport
                self?.onSportSelected?(sport)
            }
            sportViews[sport] = sportView
            stackView.addArrangedSubview(sportView)
        }
    }

    private func updateSelectionViewConstraints(for selectedSegment: SportSelectorMenuItemView) {
        selectionView.snp.remakeConstraints {
            $0.height.equalTo(Constants.selectionViewHeight)
            $0.bottom.equalTo(stackView.snp.bottom)
            $0.leading.trailing.equalTo(selectedSegment).inset(Constants.selectionViewHorizontalInset)
        }
    }

    private func updateSelection() {
        UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseInOut], animations: { [weak self] in
            guard let self = self else { return }
            self.updateSelectionViewConstraints(for: self.selectedSegment)
            self.layoutIfNeeded()
        })
    }
}
