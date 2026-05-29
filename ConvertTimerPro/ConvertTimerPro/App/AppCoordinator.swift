//
//  AppCoordinator.swift
//  ConvertTimerPro
//
//  Created by Mac Mini on 27/5/26.
//

import UIKit

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get }
    func start()
}

final class AppCoordinator: Coordinator {

    let navigationController: UINavigationController
    private let window: UIWindow

    init(window: UIWindow) {
        self.window = window
        self.navigationController = UINavigationController()
        self.navigationController.setNavigationBarHidden(true, animated: false)
    }

    func start() {
        showMain()
    }

    private func showMain() {
        let tabBarController = MainTabBarController()
        navigationController.setViewControllers([tabBarController], animated: false)

        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
