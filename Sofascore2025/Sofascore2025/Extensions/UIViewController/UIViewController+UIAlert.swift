//
//  UIViewController+UIAlert.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 15.04.2025..
//

import UIKit

extension UIViewController {

    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alert, animated: true)
    }
}
