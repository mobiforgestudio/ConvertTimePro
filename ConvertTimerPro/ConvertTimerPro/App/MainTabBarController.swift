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

        setupAppearance()

        setupTabs()
    }
}

private extension MainTabBarController {

    func setupAppearance() {

        let appearance =
            UITabBarAppearance()

        appearance.configureWithOpaqueBackground()

        appearance.backgroundColor =
            AppColor.Background.primary

        appearance.stackedLayoutAppearance
            .selected.iconColor =
            AppColor.Accent.primary

        appearance.stackedLayoutAppearance
            .selected.titleTextAttributes = [
                .foregroundColor:
                    AppColor.Accent.primary
            ]

        appearance.stackedLayoutAppearance
            .normal.iconColor =
            AppColor.Text.secondary

        appearance.stackedLayoutAppearance
            .normal.titleTextAttributes = [
                .foregroundColor:
                    AppColor.Text.secondary
            ]

        tabBar.standardAppearance =
            appearance

        if #available(iOS 15.0, *) {

            tabBar.scrollEdgeAppearance =
                appearance
        }
    }

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
                    systemName:
                        "house"
                ),
                selectedImage: UIImage(
                    systemName:
                        "house.fill"
                )
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
                selectedImage: UIImage(
                    systemName:
                        "square.grid.2x2.fill"
                )
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
                    systemName:
                        "gearshape"
                ),
                selectedImage: UIImage(
                    systemName:
                        "gearshape.fill"
                )
            )

        viewControllers = [
            home,
            tools,
            settings
        ]
    }
}
