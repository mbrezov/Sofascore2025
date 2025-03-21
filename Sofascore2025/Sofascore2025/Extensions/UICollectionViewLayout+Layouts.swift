//
//  UICollectionViewLayout+Layouts.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 20.03.2025..
//

import UIKit

extension UICollectionViewLayout {

    static func verticalFlowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.sectionHeadersPinToVisibleBounds = true
        return layout
    }
}
