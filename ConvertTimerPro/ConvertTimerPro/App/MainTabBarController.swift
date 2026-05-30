//
//  MainTabBarController.swift
//  ConvertTimerPro
//
//  Created by Mac Mini on 27/5/26.
//

import UIKit

final class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupAppearance()
        setupTabs()
    }

    private func setupTabs() {
        viewControllers = AppTab.allCases.map { tab in
            createTab(for: tab)
        }
    }

    private func createTab(for tab: AppTab) -> UIViewController {
        let rootViewController: UIViewController

        switch tab {
        case .calculator:
            rootViewController = DateDifferenceViewController()
        case .timestamp:
            rootViewController = TimestampViewController()
        case .countdown:
            rootViewController = CountdownViewController()
        case .workingDays:
            rootViewController = WorkdaysViewController()
        case .timezone:
            rootViewController = TimezoneViewController()
        }

        let navigationController = UINavigationController(rootViewController: rootViewController)
        navigationController.tabBarItem = UITabBarItem(
            title: tab.title,
            image: UIImage(systemName: tab.iconName),
            selectedImage: UIImage(systemName: tab.iconName)
        )

        return navigationController
    }

    private func setupAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.black

        appearance.stackedLayoutAppearance.normal.iconColor = UIColor.gray
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [
            .foregroundColor: UIColor.gray
        ]

        appearance.stackedLayoutAppearance.selected.iconColor = UIColor.systemPurple
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [
            .foregroundColor: UIColor.systemPurple
        ]

        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
        tabBar.tintColor = UIColor.systemPurple
        tabBar.unselectedItemTintColor = UIColor.gray
    }
}
