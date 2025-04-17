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

    private var selectedIndex: SportType?

    private var selectedSegment: SportSelectorMenuItemView? {
        if let index = selectedIndex {
            return sportViews[index]
        }
        return nil
    }

    override func addViews() {
        addSubview(stackView)
        addSubview(selectionView)
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
            $0.directionalHorizontalEdges.bottom.equalToSuperview()
        }
    }

    func setupSports(with sports: [SportType], selectedSportType: SportType) {
        for sportView in stackView.arrangedSubviews {
            stackView.removeArrangedSubview(sportView)
            sportView.removeFromSuperview()
        }

        sports.forEach { sport in
            let sportView = SportSelectorMenuItemView()
            sportView.setup(name: sport.name, image: sport.icon)
            sportView.onTap = { [weak self] in
                self?.selectedIndex = sport
                self?.updateSelection(animated: true)
                self?.onSportSelected?(sport)
            }
            sportViews[sport] = sportView
            stackView.addArrangedSubview(sportView)
        }

        selectedIndex = selectedSportType
        updateSelection(animated: false)
        onSportSelected?(selectedSportType)
    }

    private func updateSelectionViewConstraints(for selectedSegment: SportSelectorMenuItemView) {
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
}
