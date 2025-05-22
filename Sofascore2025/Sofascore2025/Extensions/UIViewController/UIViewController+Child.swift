//
//  UIViewController+Child.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 25.03.2025..
//

import UIKit

extension UIViewController {

    func addChildController(_ controller: UIViewController) {
        addChild(controller)
        view.addSubview(controller.view)
        controller.didMove(toParent: self)
    }

    func removeChildController(_ controller: UIViewController) {
        controller.willMove(toParent: nil)
        controller.view.removeFromSuperview()
        controller.removeFromParent()
    }
}
