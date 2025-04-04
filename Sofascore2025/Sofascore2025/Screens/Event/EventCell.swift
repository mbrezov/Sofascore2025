//
//  EventCell.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 19.03.2025..
//

import SnapKit
import UIKit

class EventCell: UICollectionViewCell {

    static let reuseIdentifier = "EventCell"

    private let eventView = EventView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        addViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        eventView.cleanup()
    }

    func addViews() {
        contentView.addSubview(eventView)
    }

    func setupConstraints() {
        eventView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    func bind(_ event: EventViewModel) {
        eventView.viewModel = event
    }
}
