//
//  UILabel+AttributedString.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 13.03.2025..
//

import UIKit

extension UILabel {

    func setLineHeight(_ lineHeight: CGFloat) {
        guard let labelText = text, !labelText.isEmpty else { return }

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = lineHeight
        paragraphStyle.maximumLineHeight = lineHeight
        paragraphStyle.alignment = textAlignment

        let attributes: [NSAttributedString.Key: Any] = [
            .paragraphStyle: paragraphStyle
        ]

        attributedText = NSAttributedString(string: labelText, attributes: attributes)
    }
}
