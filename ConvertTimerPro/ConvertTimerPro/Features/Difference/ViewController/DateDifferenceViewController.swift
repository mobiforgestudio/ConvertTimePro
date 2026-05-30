//
//  DateDifferenceViewController.swift
//  ConvertTimerPro
//
//  Created by Mac Mini on 30/5/26.
//

import UIKit
import SnapKit

final class DateDifferenceViewController:
    BaseViewController {

    // MARK: - Properties

    private let contentView =
        DateDifferenceContentView()

    private let viewModel =
        DateDifferenceViewModel()

    private let datePicker =
        UIDatePicker()

    private var selectingStartDate =
        true

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

extension DateDifferenceViewController {

    override func setupView() {

        contentView
            .startDateField
            .configure(
                title: "Start Date",
                date: viewModel.startDate
            )

        contentView
            .endDateField
            .configure(
                title: "End Date",
                date: viewModel.endDate
            )
    }

    func setupBindings() {

        contentView
            .startDateField
            .onTap = {
                [weak self] in

                self?.selectingStartDate = true

                self?.showDatePicker(
                    date: self?.viewModel.startDate ?? Date()
                )
            }

        contentView
            .endDateField
            .onTap = {
                [weak self] in

                self?.selectingStartDate = false

                self?.showDatePicker(
                    date: self?.viewModel.endDate ?? Date()
                )
            }

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
}

// MARK: - Result

private extension DateDifferenceViewController {

    func reloadResult() {

        let result =
            viewModel.calculate()

        contentView
            .resultCardView
            .configure(
                result: result
            )
    }
}

// MARK: - Actions

private extension DateDifferenceViewController {

    @objc
    func didTapSwap() {
        
        UIImpactFeedbackGenerator(
            style: .light
        ).impactOccurred()
        
        swapDates()
        reloadResult()
    }
}

// MARK: - Date Picker

private extension DateDifferenceViewController {

    func showDatePicker(
        date: Date
    ) {

        let alert =
            UIAlertController(
                title:
                    "\n\n\n\n\n\n\n\n\n",
                message: nil,
                preferredStyle:
                    .actionSheet
            )

        datePicker.datePickerMode =
            .date

        datePicker.preferredDatePickerStyle =
            .wheels

        datePicker.date =
            date

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

                guard let self else {
                    return
                }

                self.didSelectDate(
                    self.datePicker.date
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

        if selectingStartDate {

            viewModel.startDate =
                date

        } else {

            viewModel.endDate =
                date
        }

        if viewModel.startDate >
            viewModel.endDate {
            
            UIImpactFeedbackGenerator(
                style: .light
            ).impactOccurred()
            
            swapDates()
        }

        contentView
            .startDateField
            .configure(
                title: "Start Date",
                date: viewModel.startDate
            )

        contentView
            .endDateField
            .configure(
                title: "End Date",
                date: viewModel.endDate
            )

        reloadResult()
    }
    
    private func swapDates() {

        let temp =
            viewModel.startDate

        viewModel.startDate =
            viewModel.endDate

        viewModel.endDate =
            temp

        contentView
            .startDateField
            .configure(
                title: "Start Date",
                date: viewModel.startDate
            )

        contentView
            .endDateField
            .configure(
                title: "End Date",
                date: viewModel.endDate
            )
    }
}
