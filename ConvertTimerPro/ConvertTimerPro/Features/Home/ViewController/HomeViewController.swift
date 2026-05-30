//
//  HomeViewController.swift
//  ConvertTimerPro
//
//  Created by Mac Mini on 30/5/26.
//

import UIKit
import SwiftData

final class HomeViewController:
    BaseViewController {
    
    private let contentView =
    HomeContentView()
    
    private let workdaysEngine =
    WorkdaysEngine()
    
    private let favoriteStore =
        FavoriteStore(
            context:
                PersistenceController
                    .shared
                    .container
                    .mainContext
        )
    
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

        reloadFavorites()

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
                    openTimestamp
                ),
                for: .touchUpInside
            )

        contentView
            .today30DaysButton
            .addTarget(
                self,
                action: #selector(
                    open30DaysLater
                ),
                for: .touchUpInside
            )
        
        contentView
            .favoritesSection
            .onItemSelected = {
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
            .favoriteEmptyCard
            .onButtonTap = {
                [weak self] in

                self?.openToolsTab()
            }
    }
}

extension HomeViewController {
    private func reloadRecent() {
        
        let items = RecentManager.shared.fetch()
        
        contentView.configureRecent(
            items: items
        )
    }
    
    private func reloadFavorites() {

        let favorites =
            favoriteStore
                .favoriteItems()

        contentView
            .configureFavorites(
                items: favorites
            )

        contentView
            .updateStats(
                favoriteCount:
                    favorites.count
            )
    }
}

extension HomeViewController {
 
    @objc
    private func openTimestamp() {

        HapticEngine.shared.light()

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
    private func open30DaysLater() {

        HapticEngine.shared.light()

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

    private func openToolsTab() {

        HapticEngine.shared.light()

        guard let tabBarController =
            tabBarController
        else {
            return
        }

        tabBarController.selectedIndex = 1
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
