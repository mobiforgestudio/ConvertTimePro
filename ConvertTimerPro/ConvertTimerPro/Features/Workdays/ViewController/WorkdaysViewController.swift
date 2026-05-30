//
//  WorkdaysViewController.swift
//  ConvertTimerPro
//
//  Created by Mac Mini on 30/5/26.
//

import UIKit
import SnapKit

final class WorkdaysViewController:
    BaseViewController {

    // MARK: - Properties

    private let contentView =
        WorkdaysContentView()

    private let engine =
        WorkdaysEngine()

    private let datePicker =
        UIDatePicker()

    private var startDate =
        Date()

    private var workdays =
        30

    // MARK: - Lifecycle

    override func loadView() {

        view = contentView
    }

    override func viewDidLoad() {

        super.viewDidLoad()

        contentView
            .dateInputView
            .configure(
                title: "Start Date",
                date: startDate
            )

        contentView
            .stepperView
            .setValue(
                workdays
            )

        setupBindings()

        reloadResult()
    }
}

// MARK: - Setup

private extension WorkdaysViewController {

    func setupBindings() {

        contentView
            .dateInputView
            .onTap = {
                [weak self] in

                self?.showDatePicker()
            }

        contentView
            .stepperView
            .onValueChanged = {
                [weak self] value in

                self?.workdays =
                    value

                self?.reloadResult()
            }

        contentView
            .quickChipsView
            .onChipSelected = {
                [weak self] value in

                guard let self else {
                    return
                }

                workdays = value

                contentView
                    .stepperView
                    .setValue(value)

                contentView
                    .quickChipsView
                    .select(value)

                reloadResult()
            }
    }
}

// MARK: - Actions

private extension WorkdaysViewController {

    func reloadResult() {

        let result =
            engine.calculate(
                from: startDate,
                workdays: workdays
            )

        contentView
            .resultCardView
            .configure(
                result: result
            )
    }
}

// MARK: - Date Picker

private extension WorkdaysViewController {

    func showDatePicker() {

        let alert =
            UIAlertController(
                title: "\n\n\n\n\n\n\n\n\n",
                message: nil,
                preferredStyle: .actionSheet
            )

        datePicker.datePickerMode =
            .date

        datePicker.preferredDatePickerStyle =
            .wheels

        datePicker.date =
            startDate

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

                self?.didSelectDate(
                    self?.datePicker.date ??
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

        startDate =
            date

        contentView
            .dateInputView
            .configure(
                title: "Start Date",
                date: date
            )

        reloadResult()
    }
}
