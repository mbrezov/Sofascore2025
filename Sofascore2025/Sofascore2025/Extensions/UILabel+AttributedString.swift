//
//  UILabel+AttributedString.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 13.03.2025..
//

import UIKit

extension UILabel {

    func setTextWithLineHeight(_ text: String, _ lineHeight: CGFloat = 16) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = lineHeight
        paragraphStyle.maximumLineHeight = lineHeight
        paragraphStyle.alignment = textAlignment

        let attributes: [NSAttributedString.Key: Any] = [
            .paragraphStyle: paragraphStyle
        ]

        attributedText = NSAttributedString(string: text, attributes: attributes)
    }
}
