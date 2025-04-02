//
//  SportSelectorMenuViewController.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 18.03.2025..
//

import SnapKit
import SofaAcademic
import UIKit

class SportSelectorMenuViewController: UIViewController, BaseViewProtocol {

    private enum Constants {

        static let cornerRadius: CGFloat = 2
        static let selectionViewHeight: CGFloat = 4
        static let selectionViewHorizontalInset: CGFloat = 8
    }

    private let stackView = UIStackView()
    private let selectionView = UIView()

    private var sportViews: [SportType: SportSelectorMenuView] = [:]

    var onSportSelected: ((SportType) -> Void)?

    var selectedIndex: SportType = .football {
        didSet {
            updateSelection()
        }
    }

    init(sports: [SportType] = SportType.allCases) {
        super.init(nibName: nil, bundle: nil)

        sports.forEach { sport in
            let sportView = SportSelectorMenuView()
            sportView.setup(name: sport.name, image: sport.icon)
            sportView.onTap = { [weak self] in
                self?.selectedIndex = sport
                self?.onSportSelected?(sport)
            }
            sportViews[sport] = sportView
            stackView.addArrangedSubview(sportView)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .primaryDefault

        addViews()
        styleViews()
        setupConstraints()
    }

    func addViews() {
        view.addSubview(stackView)
        view.addSubview(selectionView)
    }

    func styleViews() {
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually

        selectionView.backgroundColor = .surface1
        selectionView.layer.cornerRadius = Constants.cornerRadius
        selectionView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }

    func setupConstraints() {
        stackView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.bottom.equalToSuperview()
        }

        updateSelectionViewConstraints(for: selectedSegment)
    }

    private var selectedSegment: UIView {
        return sportViews[selectedIndex] ?? UIView()
    }

    private func updateSelectionViewConstraints(for selectedSegment: UIView) {
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
            self.view.layoutIfNeeded()
        })
    }
}
