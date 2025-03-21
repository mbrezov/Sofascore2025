//
//  LeagueSectionDividerView.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 21.03.2025..
//

import UIKit

class LeagueSectionDividerView: UICollectionReusableView {

    static let reuseIdentifier = "LeagueSectionDividerView"

    static let height: CGFloat = 1

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .surfaceLv4
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
