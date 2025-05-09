//
//  OutlineTextField.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 23.04.2025..
//

import SnapKit
import SofaAcademic
import UIKit

class OutlineTextField: UITextField, BaseViewProtocol {

    private enum Padding {

        static let leftInset: CGFloat = 16
    }

    private enum Constants {

        static let height: CGFloat = 48
    }

    init() {
        super.init(frame: .zero)

        styleViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func addViews() {}

    func styleViews() {
        backgroundColor = .surface1
        layer.borderColor = UIColor.surfaceLv2.cgColor
        layer.borderWidth = 1

        leftView = UIView(frame: CGRect(x: 0, y: 0, width: Padding.leftInset, height: frame.height))
        leftViewMode = .always
    }

    func setupConstraints() {
        self.snp.makeConstraints {
            $0.height.equalTo(Constants.height)
        }
    }
}
