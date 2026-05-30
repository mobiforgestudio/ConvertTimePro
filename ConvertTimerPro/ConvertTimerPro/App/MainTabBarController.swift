//
//  MainTabBarController.swift
//  ConvertTimerPro
//
//  Created by Mac Mini on 27/5/26.
//

import UIKit

final class MainTabBarController:
    UITabBarController {

    override func viewDidLoad() {

        super.viewDidLoad()

        setupTabs()
    }
}

private extension MainTabBarController {

    func setupTabs() {

        let home =
            UINavigationController(
                rootViewController:
                    HomeViewController()
            )

        home.tabBarItem =
            UITabBarItem(
                title: "Home",
                image: UIImage(
                    systemName: "house"
                ),
                tag: 0
            )

        let tools =
            UINavigationController(
                rootViewController:
                    ToolsViewController()
            )

        tools.tabBarItem =
            UITabBarItem(
                title: "Tools",
                image: UIImage(
                    systemName:
                        "square.grid.2x2"
                ),
                tag: 1
            )

        let settings =
            UINavigationController(
                rootViewController:
                    SettingsViewController()
            )

        settings.tabBarItem =
            UITabBarItem(
                title: "Settings",
                image: UIImage(
                    systemName: "gear"
                ),
                tag: 2
            )

        viewControllers = [

            home,
            tools,
            settings
        ]
    }
}
