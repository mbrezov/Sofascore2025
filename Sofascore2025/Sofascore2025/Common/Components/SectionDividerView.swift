//
//  SectionDividerView.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 21.03.2025..
//

import UIKit

class SectionDividerView: UICollectionReusableView {

    static let reuseIdentifier = "SectionDividerView"

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .surfaceLv4
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
