//
//  UIViewController+UINavigation.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 08.04.2025..
//

import UIKit

extension UIViewController {

    // MARK: - push/present

    func navigateTo(_ viewController: UIViewController, animated: Bool) {
        navigationController?.pushViewController(viewController, animated: animated)
    }

    func presentFullScreenModal(_ viewController: UIViewController, animated: Bool) {
        viewController.modalPresentationStyle = .fullScreen
        viewController.modalTransitionStyle = .coverVertical
        present(viewController, animated: animated)
    }

    // MARK: - pop/dismiss

    func navigateBack(animated: Bool) {
        navigationController?.popViewController(animated: animated)
    }

    func dismissModal(animated: Bool) {
        dismiss(animated: animated)
    }
}
