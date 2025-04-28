//
//  AppRootViewController.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 24.04.2025..
//

import UIKit

class AppRootViewController: UIViewController {

    private var currentViewController: UIViewController?

    override func viewDidLoad() {
        super.viewDidLoad()

        setInitialViewController()

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(authStatusChanged),
            name: .authStatusChanged,
            object: nil
        )
    }

    private func setInitialViewController() {
        let currentVC = makeRootViewController()
        addChildController(currentVC)
        currentViewController = currentVC
    }

    @objc private func authStatusChanged() {
        let newVC = makeRootViewController()
        transition(to: newVC)
    }

    private func makeRootViewController() -> UIViewController {
        let rootVC = AuthService.isAuthed ? MainViewController() : LoginViewController()
        return UINavigationController(rootViewController: rootVC)
    }

    private func transition(to newVC: UIViewController) {
        if self.presentedViewController != nil {
            self.dismiss(animated: true)
        }

        guard let oldVC = currentViewController else {
            addChildController(newVC)
            currentViewController = newVC
            return
        }

        removeChildController(oldVC)
        addChildController(newVC)
        currentViewController = newVC
    }
}
