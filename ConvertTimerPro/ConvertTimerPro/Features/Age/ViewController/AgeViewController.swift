//
//  AgeViewController.swift
//  ConvertTimerPro
//
//  Created by Mac Mini on 30/5/26.
//

import UIKit
import SnapKit

final class AgeViewController:
    BaseViewController {
    
    private let contentView =
    AgeContentView()
    
    private let viewModel =
    AgeViewModel()
    
    private let datePicker =
    UIDatePicker()
    
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

extension AgeViewController {
    
    override func setupView() {
        
        contentView
            .birthDateField
            .configure(
                title: "Date of Birth",
                date: viewModel.birthDate
            )
    }
    
    func setupBindings() {
        
        contentView
            .birthDateField
            .onTap = {
                [weak self] in
                
                self?.showDatePicker()
            }
    }
}

// MARK: - Result

private extension AgeViewController {
    
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

// MARK: - Date Picker

private extension AgeViewController {
    
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
            .date
        
        datePicker.preferredDatePickerStyle =
            .wheels
        
        datePicker.maximumDate =
        Date()
        
        datePicker.date =
        viewModel.birthDate
        
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
        
        viewModel.birthDate =
        date
        
        contentView
            .birthDateField
            .configure(
                title: "Date of Birth",
                date: date
            )
        
        reloadResult()
    }
}
