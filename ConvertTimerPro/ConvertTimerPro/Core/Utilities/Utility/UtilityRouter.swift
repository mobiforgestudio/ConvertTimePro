//
//  UtilityRouter.swift
//  ConvertTimerPro
//
//  Created by Mac Mini on 30/5/26.
//

import UIKit

enum UtilityRouter {

    static func makeViewController(
        for item: UtilityItem
    ) -> UIViewController {

        switch item {

        case .calculator:
            return CalculatorViewController()

        case .timestamp:
            return TimestampViewController()

        case .countdown:
            return CountdownViewController()

        case .workdays:
            return WorkdaysViewController()

        case .timezone:
            return TimezoneViewController()

        case .age:
            return AgeViewController()

        case .dateDifference:
            return DateDifferenceViewController()
        }
    }

    static func open(
        _ item: UtilityItem,
        from viewController: UIViewController
    ) {

        RecentManager.shared
            .save(item)

        let destination =
            makeViewController(
                for: item
            )
        destination.hidesBottomBarWhenPushed = true
        
        viewController
            .navigationController?
            .pushViewController(
                destination,
                animated: true
            )
    }
}
