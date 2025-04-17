//
//  UIViewController+UINavigation.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 08.04.2025..
//

import UIKit

extension UIViewController {

    // MARK: - push/present

    func push(_ viewController: UIViewController, animated: Bool) {
        navigationController?.pushViewController(viewController, animated: animated)
    }

    func presentFullScreen(_ viewController: UIViewController, animated: Bool) {
        viewController.modalPresentationStyle = .fullScreen
        viewController.modalTransitionStyle = .coverVertical
        present(viewController, animated: animated)
    }

    // MARK: - pop

    func pop(animated: Bool) {
        navigationController?.popViewController(animated: animated)
    }
}
