//
//  CountdownViewController.swift
//  ConvertTimerPro
//
//  Created by Mac Mini on 29/5/26.
//

import UIKit
import SnapKit
import Then

final class CountdownViewController:
    BaseViewController {

    // MARK: - Properties

    private let contentView =
        CountdownContentView()

    private let datePicker =
        UIDatePicker()
    
    private var selectedDate =
        Date()
    
    private let engine =
        CountdownEngine()

    private var currentResult:
        CountdownResult?
    
    private var eventName = ""
    private var timer: Timer?
    
    private var startOfToday: Date {

        Calendar.current.startOfDay(
            for: Date()
        )
    }
    
    // MARK: - Lifecycle

    override func loadView() {

        view = contentView
    }

    override func viewDidLoad() {

        super.viewDidLoad()

        setupBindings()

        loadInitialData()
        
        startTimer()
        
        tapKeyboard()
    }
    
    deinit {
        timer?.invalidate()
    }
    
    func tapKeyboard() {
        let tap =
            UITapGestureRecognizer(
                target: self,
                action: #selector(
                    dismissKeyboard
                )
            )

        tap.cancelsTouchesInView = false

        view.addGestureRecognizer(
            tap
        )
    }
    
    private func startTimer() {

        timer?.invalidate()

        timer =
            Timer.scheduledTimer(
                withTimeInterval: 1,
                repeats: true
            ) {
                [weak self] _ in

                guard
                    let self
                else {
                    return
                }

                self.updateResult(
                    self.selectedDate
                )
            }
    }
    
    @objc
    private func dismissKeyboard() {
        view.endEditing(true)
    }
}

// MARK: - Setup

private extension CountdownViewController {

    func setupBindings() {

        contentView
            .quickChipsView
            .onChipSelected = {
                [weak self] chip in

                self?.handleChip(
                    chip
                )
            }
        
        contentView
            .dateInputView
            .onTap = {
                [weak self] in

                self?.showDatePicker()
            }
        
        contentView
            .eventTextField
            .addTarget(
                self,
                action: #selector(
                    eventNameChanged
                ),
                for: .editingChanged
            )
        contentView
            .eventTextField
            .delegate = self
        
        contentView
            .resultCardView
            .onCopy = {
                [weak self] in

                self?.copyResult()
            }
    }

    func loadInitialData() {

        selectedDate =
            Calendar.current.date(
                byAdding: .day,
                value: 1,
                to: startOfToday
            ) ?? startOfToday

        contentView
            .dateInputView
            .configure(
                title: "Target Date",
                date: selectedDate
            )

        updateResult(
            selectedDate
        )
    }
}

// MARK: - Actions

private extension CountdownViewController {

    func handleChip(
        _ chip: String
    ) {

        let calendar =
            Calendar.current

        let targetDate: Date?

        switch chip {

        case "Today":

            targetDate =
                startOfToday

        case "Tomorrow":

            targetDate =
                calendar.date(
                    byAdding: .day,
                    value: 1,
                    to: startOfToday
                )

        case "Next Week":

            targetDate =
                calendar.date(
                    byAdding: .weekOfYear,
                    value: 1,
                    to: startOfToday
                )

        case "Next Month":

            targetDate =
                calendar.date(
                    byAdding: .month,
                    value: 1,
                    to: startOfToday
                )

        default:

            targetDate = nil
        }

        guard
            let targetDate
        else {
            return
        }

        selectedDate =
            targetDate

        contentView
            .dateInputView
            .configure(
                title: "Target Date",
                date: targetDate
            )

        updateResult(
            targetDate
        )
    }

    func updateResult(
        _ targetDate: Date
    ) {

        let result =
            engine.calculate(
                targetDate: targetDate,
                eventName: eventName
            )

        currentResult = result

        contentView
            .resultCardView
            .configure(
                result: result
            )
    }
}

private extension CountdownViewController {
    private func showDatePicker() {

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
            selectedDate

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

    private func didSelectDate(
        _ date: Date
    ) {

        selectedDate =
            date

        contentView
            .dateInputView
            .configure(
                title: "Target Date",
                date: date
            )

        updateResult(
            date
        )
    }
    
    @objc
    private func eventNameChanged() {

        eventName =
            contentView
                .eventTextField
                .text ?? ""

        updateResult(
            selectedDate
        )
    }
}

extension CountdownViewController: UITextFieldDelegate {

    func textFieldShouldReturn(
        _ textField: UITextField
    ) -> Bool {

        textField.resignFirstResponder()

        return true
    }
}

extension CountdownViewController {
    private func copyResult() {

        guard
            let result =
                currentResult
        else {
            return
        }

        let formatter =
            DateFormatter()

        formatter.dateStyle = .medium

        let text: String

        if result.isOverdue {

            text =
                "\(result.days) days ago (\(formatter.string(from: result.targetDate)))"

        } else {

            text =
                "\(result.days) days until \(formatter.string(from: result.targetDate))"
        }

        UIPasteboard
            .general
            .string = text

        ToastPresenter.shared.show(
            message: "Copied",
            in: view
        )
    }
}
