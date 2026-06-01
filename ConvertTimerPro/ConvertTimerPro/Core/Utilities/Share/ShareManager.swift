//
//  ShareManager.swift
//  ConvertTimerPro
//
//  Created by Mac Mini on 1/6/26.
//

import UIKit

enum ShareManager {

    static func share(
        text: String,
        from viewController: UIViewController
    ) {

        let activityVC =
            UIActivityViewController(
                activityItems: [text],
                applicationActivities: nil
            )

        if let popover =
            activityVC.popoverPresentationController {

            popover.sourceView =
                viewController.view

            popover.sourceRect =
                CGRect(
                    x: viewController.view.bounds.midX,
                    y: viewController.view.bounds.midY,
                    width: 0,
                    height: 0
                )
        }

        viewController.present(
            activityVC,
            animated: true
        )
    }
}
