//
//  TimezoneViewController.swift
//  ConvertTimerPro
//
//  Created by Mac Mini on 30/5/26.
//

import UIKit
import SnapKit

final class TimezoneViewController:
    BaseViewController {

    // MARK: - Properties

    private let contentView =
        TimezoneContentView()

    private let viewModel =
        TimezoneViewModel()

    private let datePicker =
        UIDatePicker()

    private var selectingFrom =
        false

    // MARK: - Lifecycle

    override func loadView() {

        view = contentView
    }

    override func viewDidLoad() {

        super.viewDidLoad()

        setupView()

        setupBindings()

        reloadResult()
    }
}

// MARK: - Setup

extension TimezoneViewController {

    override func setupView() {

        contentView
            .fromField
            .configure(
                title: "From Timezone",
                value: viewModel
                    .fromTimeZone
                    .title
            )

        contentView
            .toField
            .configure(
                title: "To Timezone",
                value: viewModel
                    .toTimeZone
                    .title
            )

        contentView
            .dateField
            .configure(
                title: "Date & Time",
                date: viewModel.selectedDate,
                mode: .dateTime
            )
        
        contentView
            .swapButton
            .addTarget(
                self,
                action: #selector(
                    didTapSwap
                ),
                for: .touchUpInside
            )
    }

    func setupBindings() {

        contentView
            .fromField
            .onTap = {
                [weak self] in

                self?.selectingFrom = true

                self?.showTimezonePicker()
            }

        contentView
            .toField
            .onTap = {
                [weak self] in

                self?.selectingFrom = false

                self?.showTimezonePicker()
            }

        contentView
            .dateField
            .onTap = {
                [weak self] in

                self?.showDatePicker()
            }
    }
}

// MARK: - Reload

private extension TimezoneViewController {

    func reloadResult() {

        let result =
            viewModel.convert()

        contentView
            .resultCardView
            .configure(
                result: result
            )
    }
    
    @objc
    func didTapSwap() {

        let temp =
            viewModel.fromTimeZone

        viewModel.fromTimeZone =
            viewModel.toTimeZone

        viewModel.toTimeZone =
            temp

        contentView
            .fromField
            .configure(
                title: "From Timezone",
                value: viewModel
                    .fromTimeZone
                    .title
            )

        contentView
            .toField
            .configure(
                title: "To Timezone",
                value: viewModel
                    .toTimeZone
                    .title
            )

        reloadResult()
    }
}

// MARK: - Timezone Picker

private extension TimezoneViewController {

    func showTimezonePicker() {

        let alert =
            UIAlertController(
                title: "Select Timezone",
                message: nil,
                preferredStyle: .actionSheet
            )

        TimezoneItem
            .allCases
            .forEach { item in

                alert.addAction(
                    UIAlertAction(
                        title: item.title,
                        style: .default
                    ) {
                        [weak self] _ in

                        self?
                            .didSelectTimezone(
                                item
                            )
                    }
                )
            }

        alert.addAction(
            UIAlertAction(
                title: "Cancel",
                style: .cancel
            )
        )

        present(
            alert,
            animated: true
        )
    }

    func didSelectTimezone(
        _ item: TimezoneItem
    ) {

        if selectingFrom {

            viewModel
                .fromTimeZone = item

            contentView
                .fromField
                .configure(
                    title: "From Timezone",
                    value: item.title
                )

        } else {

            viewModel
                .toTimeZone = item

            contentView
                .toField
                .configure(
                    title: "To Timezone",
                    value: item.title
                )
        }

        reloadResult()
    }
}

// MARK: - Date Picker

private extension TimezoneViewController {

    func showDatePicker() {

        let alert =
            UIAlertController(
                title:
                    "\n\n\n\n\n\n\n\n\n",
                message: nil,
                preferredStyle:
                    .actionSheet
            )

        datePicker.datePickerMode =
            .dateAndTime

        datePicker.preferredDatePickerStyle =
            .wheels

        datePicker.date =
            viewModel
                .selectedDate

        alert.view.addSubview(
            datePicker
        )

        datePicker.snp.makeConstraints {

            $0.top.equalToSuperview()
                .offset(20)

            $0.leading.trailing
                .equalToSuperview()

            $0.height.equalTo(180)
        }

        alert.addAction(
            UIAlertAction(
                title: "Done",
                style: .default
            ) {
                [weak self] _ in

                self?
                    .didSelectDate(
                        self?
                            .datePicker
                            .date ??
                        Date()
                    )
            }
        )

        alert.addAction(
            UIAlertAction(
                title: "Cancel",
                style: .cancel
            )
        )

        present(
            alert,
            animated: true
        )
    }

    func didSelectDate(
        _ date: Date
    ) {

        viewModel
            .selectedDate =
            date

        contentView
            .dateField
            .configure(
                title: "Date & Time",
                date: date
            )

        reloadResult()
    }
}
