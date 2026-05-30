//
//  HomeViewController.swift
//  ConvertTimerPro
//
//  Created by Mac Mini on 30/5/26.
//

import UIKit

final class HomeViewController:
    BaseViewController {
    
    private let contentView =
    HomeContentView()
    
    private let workdaysEngine =
    WorkdaysEngine()
    
    override func loadView() {
        
        view = contentView
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setupBindings()
    }
    
    override func viewWillAppear(
        _ animated: Bool
    ) {
        
        super.viewWillAppear(
            animated
        )
        
        reloadRecent()
    }
}

extension HomeViewController {
    
    func setupBindings() {
        
        contentView
            .onUtilitySelected = {
                [weak self] item in
                
                guard let self else {
                    return
                }
                
                UtilityRouter.open(
                    item,
                    from: self
                )
            }
        
        contentView
            .currentTimestampButton
            .addTarget(
                self,
                action: #selector(
                    didTapTimestamp
                ),
                for: .touchUpInside
            )
        
        contentView
            .today30DaysButton
            .addTarget(
                self,
                action: #selector(
                    didTap30Days
                ),
                for: .touchUpInside
            )
        
        contentView
            .workdays90Button
            .addTarget(
                self,
                action: #selector(
                    didTap90Workdays
                ),
                for: .touchUpInside
            )
    }
}

extension HomeViewController {
    private func reloadRecent() {
        
        let items = RecentManager.shared.fetch()
        
        contentView.configureRecent(
            items: items
        )
    }
}

extension HomeViewController {
    @objc
    private func didTapTimestamp() {
        
        let timestamp =
        String(
            Int(
                Date()
                    .timeIntervalSince1970
            )
        )
        
        showResult(
            title: "Current Timestamp",
            value: timestamp
        )
    }
    
    @objc
    private func didTap30Days() {
        
        let formatter =
        DateFormatter()
        
        formatter.dateStyle =
            .medium
        
        let result =
        Calendar.current.date(
            byAdding: .day,
            value: 30,
            to: Date()
        )
        
        showResult(
            title: "Today + 30 Days",
            value:
                formatter.string(
                    from: result ?? Date()
                )
        )
    }
    
    @objc
    private func didTap90Workdays() {
        
        let result =
        workdaysEngine.calculate(from: Date(),
                                 workdays: 90
        )
        
        let formatter =
        DateFormatter()
        
        formatter.dateStyle =
            .medium
        
        showResult(
            title: "Today + 90 Workdays",
            value:
                formatter.string(
                    from: result.targetDate
                )
        )
    }
    
    private func showResult(
        title: String,
        value: String
    ) {
        
        let vc =
        ResultSheetViewController(
            title: title,
            value: value
        )
        
        present(
            vc,
            animated: true
        )
    }
}
