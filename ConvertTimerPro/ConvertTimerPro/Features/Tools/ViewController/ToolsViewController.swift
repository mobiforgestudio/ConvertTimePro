//
//  ToolsViewController.swift
//  ConvertTimerPro
//
//  Created by Mac Mini on 30/5/26.
//

import UIKit

final class ToolsViewController:
    BaseViewController {

    private let contentView =
        ToolsContentView()

    override func loadView() {

        view = contentView
    }

    override func viewDidLoad() {

        super.viewDidLoad()

        setupSections()
    }
}

private extension ToolsViewController {

    func setupSections() {

        contentView.timeSection
            .configure(
                title: "Time",
                items: [
                    .timestamp,
                    .countdown,
                    .timezone
                ]
            )

        contentView.dateSection
            .configure(
                title: "Date",
                items: [
                    .workdays,
                    .age,
                    .dateDifference
                ]
            )

        contentView.calculationSection
            .configure(
                title: "Calculation",
                items: [
                    .calculator
                ]
            )

        [
            contentView.timeSection,
            contentView.dateSection,
            contentView.calculationSection
        ].forEach {

            $0.onItemSelected = {
                [weak self] item in

                guard let self else {
                    return
                }

                UtilityRouter.open(
                    item,
                    from: self
                )
            }
        }
    }
}
