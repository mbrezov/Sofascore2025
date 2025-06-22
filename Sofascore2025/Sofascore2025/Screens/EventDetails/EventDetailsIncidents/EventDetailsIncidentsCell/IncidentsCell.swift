//
//  IncidentsCell.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 24.05.2025..
//

import UIKit
import SnapKit

class IncidentsCell: UICollectionViewCell {

    static let reuseIdentifier = "IncidentsCell"

    private let incidentCellView = IncidentsCellView()

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
        incidentCellView.cleanup()
    }

    func addViews() {
        contentView.addSubview(incidentCellView)
    }

    func setupConstraints() {
        incidentCellView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    func bind(_ incidentsCell: IncidentsCellViewModel) {
        incidentCellView.configure(incidentsCell.type,
                                   incidentsCell.minuteText,
                                   incidentsCell.isHomeTeam,
                                   incidentsCell.player,
                                   incidentsCell.score,
                                   incidentsCell.description,
                                   incidentsCell.sportType)
    }
}
