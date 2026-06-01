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
    
    private var latestResult:
    DateDifferenceResult?
    
    private lazy var dateFormatter:
    DateFormatter = {
        
        let formatter =
        DateFormatter()
        
        formatter.dateStyle =
            .medium
        
        return formatter
    }()
    
    // MARK: - Lifecycle
    
    override func loadView() {
        
        view = contentView
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setupView()
        
        setupBindings()
        
        setupNavigationActions(
            copyAction: #selector(
                copyResult
            ),
            shareAction: #selector(
                shareResult
            )
        )
        
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
        
        latestResult =
        result
        
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

extension DateDifferenceViewController {
    
    @objc
    private func copyResult() {
        
        ClipboardManager.copy(
            text: buildShareText()
        )
        
        ToastPresenter.shared.show(
            message: "Copied")
    }
    
    @objc
    private func shareResult() {
        
        ShareManager.share(
            text: buildShareText(),
            from: self
        )
    }
    
    private func buildShareText()
    -> String {

        guard let result =
            latestResult else {

            return ""
        }

        var breakdown: [String] = []

        if result.years > 0 {
            breakdown.append(
                "\(result.years) \(result.years == 1 ? "Year" : "Years")"
            )
        }

        if result.months > 0 {
            breakdown.append(
                "\(result.months) \(result.months == 1 ? "Month" : "Months")"
            )
        }

        if result.days > 0 {
            breakdown.append(
                "\(result.days) \(result.days == 1 ? "Day" : "Days")"
            )
        }

        let detail =
            breakdown.joined(
                separator: " • "
            )

        return """
        Date Difference

        Start Date: \(dateFormatter.string(from: viewModel.startDate))
        End Date: \(dateFormatter.string(from: viewModel.endDate))

        Total Difference: \(result.totalDays.formatted()) Days

        \(detail)

        Generated by ConvertTimer Pro
        """
    }
}
