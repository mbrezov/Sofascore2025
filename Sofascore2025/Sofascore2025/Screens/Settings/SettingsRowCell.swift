//
//  SettingsRowCell.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 26.04.2025..
//

import SnapKit
import UIKit

class SettingsRowCell: UICollectionViewCell {

    static let reuseIdentifier = "SettingsRowCell"

    private let rowView = SettingsRowView()

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
        rowView.cleanup()
    }

    func addViews() {
        contentView.addSubview(rowView)
    }

    func setupConstraints() {
        rowView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    func bind(_ settingsRow: SettingsRow) {
        rowView.configure(settingsRow.title, settingsRow.subtitle)
    }
}
