//
//  UILabel+AttributedString.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 13.03.2025..
//

import UIKit

extension UILabel {

    func setText(_ text: String, withLineHeight lineHeight: CGFloat) {
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
