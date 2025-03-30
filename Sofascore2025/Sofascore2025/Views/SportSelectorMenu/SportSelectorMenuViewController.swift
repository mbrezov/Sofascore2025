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

    private let viewModel: EventsViewModelProtocol

    private let stackView = UIStackView()
    private let segmentItemView1 = SportSelectorMenuView()
    private let segmentItemView2 = SportSelectorMenuView()
    private let segmentItemView3 = SportSelectorMenuView()
    private let selectionView = UIView()

    private var segmentMapping: [SportType: UIView] {
        return [
            .football: segmentItemView1,
            .basketball: segmentItemView2,
            .americanFootball: segmentItemView3
        ]
    }

    private var selectedSegment: UIView {
        guard let segment = segmentMapping[selectedIndex] else {
            return segmentItemView1
        }
        return segment
    }

    var selectedIndex: SportType = .football {
       didSet {
           updateSelection()
       }
    }

    init(viewModel: EventsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)

        viewModel.selectSport(selectedIndex)
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
        setupBindings()
    }

    func addViews() {
        view.addSubview(stackView)
        stackView.addArrangedSubview(segmentItemView1)
        stackView.addArrangedSubview(segmentItemView2)
        stackView.addArrangedSubview(segmentItemView3)
        stackView.addSubview(selectionView)
    }

    func styleViews() {
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually

        selectionView.backgroundColor = .surface1
        selectionView.layer.cornerRadius = Constants.cornerRadius
        selectionView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]

        segmentItemView1.setup(name: .football, image: .icFootball)
        segmentItemView2.setup(name: .basketball, image: .icBasketball)
        segmentItemView3.setup(name: .americanFootball, image: .icAmericanFootball)
    }

    func setupConstraints() {
        stackView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.bottom.equalToSuperview()
        }

        updateSelectionViewConstraints(for: selectedSegment)
    }

    func updateSelectionViewConstraints(for selectedSegment: UIView) {
        selectionView.snp.remakeConstraints {
            $0.height.equalTo(Constants.selectionViewHeight)
            $0.bottom.equalTo(stackView.snp.bottom)
            $0.leading.trailing.equalTo(selectedSegment).inset(Constants.selectionViewHorizontalInset)
        }
    }

    private func setupBindings() {
        segmentItemView1.onTap = { [weak self] in
            self?.selectedIndex = .football
        }

        segmentItemView2.onTap = { [weak self] in
            self?.selectedIndex = .basketball
        }

        segmentItemView3.onTap = { [weak self] in
            self?.selectedIndex = .americanFootball
        }
    }

    private func updateSelection() {
        viewModel.selectSport(selectedIndex)
        UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseInOut], animations: { [weak self] in
            guard let self = self else { return }
            self.updateSelectionViewConstraints(for: self.selectedSegment)
            self.view.layoutIfNeeded()
        })
    }
}
