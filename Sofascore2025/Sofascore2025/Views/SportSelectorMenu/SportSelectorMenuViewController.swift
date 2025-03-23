//
//  SportSelectorMenuViewController.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 18.03.2025..
//

import UIKit
import SofaAcademic
import SnapKit

class SportSelectorMenuViewController: UIViewController, BaseViewProtocol {

    private enum Constants {

        static let cornerRadius: CGFloat = 2
        static let selectionViewHeight: CGFloat = 4
        static let selectionViewHorizontalInset: CGFloat = 8
    }

    private let stackView = UIStackView()
    private let segmentItem1 = SportSelectorMenuButton()
    private let segmentItem2 = SportSelectorMenuButton()
    private let segmentItem3 = SportSelectorMenuButton()
    private let selectionView = UIView()

    private var segments: [UIButton] {
        [segmentItem1, segmentItem2, segmentItem3]
    }

    private var selectedSegment: UIButton {
        segments[selectedIndex]
    }

    var selectedIndex: Int = 0 {
       didSet {
           updateSelection()
       }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .primaryDefault

        addViews()
        styleViews()
        setupConstraints()

        view.layoutIfNeeded()
    }

    func addViews() {
        view.addSubview(stackView)
        stackView.addArrangedSubview(segmentItem1)
        stackView.addArrangedSubview(segmentItem2)
        stackView.addArrangedSubview(segmentItem3)
        stackView.addSubview(selectionView)
    }

    func styleViews() {
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually

        selectionView.backgroundColor = .surface1
        selectionView.layer.cornerRadius = Constants.cornerRadius
        selectionView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]

        segmentItem1.setup(name: .football, image: .icFootball, tag: 0, selector: #selector(buttonTapped(_:)))
        segmentItem2.setup(name: .basketball, image: .icBasketball, tag: 1, selector: #selector(buttonTapped(_:)))
        segmentItem3.setup(name: .americanFootball, image: .icAmericanFootball, tag: 2, selector: #selector(buttonTapped(_:)))
    }

    func setupConstraints() {
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        updateSelectionViewConstraints(for: selectedSegment)
    }

    func updateSelectionViewConstraints(for selectedSegment: UIButton) {
        selectionView.snp.remakeConstraints {
            $0.height.equalTo(Constants.selectionViewHeight)
            $0.bottom.equalTo(stackView.snp.bottom)
            $0.leading.trailing.equalTo(selectedSegment).inset(Constants.selectionViewHorizontalInset)
        }
    }

    @objc private func buttonTapped(_ sender: UIButton) {
        selectedIndex = sender.tag
    }

    private func updateSelection() {
        UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseInOut], animations: { [weak self] in
            guard let self = self else { return }
            self.updateSelectionViewConstraints(for: self.selectedSegment)
            self.view.layoutIfNeeded()
        })
    }
}
