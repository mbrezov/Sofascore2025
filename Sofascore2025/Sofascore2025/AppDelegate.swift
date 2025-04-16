//
//  AppDelegate.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 05.03.2025..
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        window = UIWindow()
        let rootViewController: UINavigationController = .init(rootViewController: MainViewController())
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
        return true
    }
}
