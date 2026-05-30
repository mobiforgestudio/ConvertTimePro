//
//  ToolsViewController.swift
//  ConvertTimerPro
//
//  Created by Mac Mini on 30/5/26.
//

import UIKit
import SwiftData

final class ToolsViewController:
    BaseViewController {
    
    private let contentView =
    ToolsContentView()
    
    private let searchEngine =
    UtilitySearchEngine()
    
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
        
        setupSections()
        
        setupSearch()
        
        setupKeyboardDismiss()
    }
}

private extension ToolsViewController {
    
    private func setupSections() {
        
        reloadSections(
            items: UtilityItem.allCases
        )
        [
            contentView.timeSection,
            contentView.dateSection,
            contentView.calculationSection,
            contentView.searchResultSection
        ]
        .forEach { section in
            
            section.onItemSelected = {
                [weak self] item in
                
                guard let self else {
                    return
                }
                self.dismissKeyboard()
                UtilityRouter.open(
                    item,
                    from: self
                )
            }
            
            section.onFavoriteTapped = {
                [weak self] item in

                self?.toggleFavorite(
                    item
                )
            }
        }
    }
    
    private func setupSearch() {
        
        contentView.searchTextField
            .delegate = self
        
        contentView.searchTextField
            .addTarget(
                self,
                action: #selector(
                    searchChanged
                ),
                for: .editingChanged
            )
    }
    
    private func setupKeyboardDismiss() {
        
        let tap =
        UITapGestureRecognizer(
            target: self,
            action: #selector(
                dismissKeyboard
            )
        )
        
        tap.cancelsTouchesInView =
        false
        
        view.addGestureRecognizer(
            tap
        )
    }
    
    @objc
    private func dismissKeyboard() {
        
        view.endEditing(true)
    }
    
    @objc
    private func searchChanged() {
        
        let query =
        contentView
            .searchTextField
            .text ?? ""
        
        let trimmed =
        query.trimmingCharacters(
            in: .whitespacesAndNewlines
        )
        
        if trimmed.isEmpty {
            
            contentView.showCategories()
            
            reloadSections(
                items:
                    UtilityItem.allCases
            )
            
            return
        }
        
        let result =
        searchEngine.search(
            query: trimmed,
            in: UtilityItem.allCases
        )
        
        contentView.showSearchResults(
            result
        )
        
        contentView.setEmptyState(
            visible:
                result.isEmpty
        )
    }
    
    private func toggleFavorite(
        _ item: UtilityItem
    ) {

        let wasFavorite =
            favoriteStore
                .isFavorite(
                    item
                )

        favoriteStore.toggle(
            item
        )

        ToastPresenter.shared.show(
            message:
                wasFavorite
                ? "Removed from Favorites"
                : "Added to Favorites"
        )

        refreshCurrentState()
    }
    
    private func refreshCurrentState() {

        let query =
            contentView
                .searchTextField
                .text ?? ""

        let trimmed =
            query.trimmingCharacters(
                in: .whitespacesAndNewlines
            )

        if trimmed.isEmpty {

            reloadSections(
                items:
                    UtilityItem.allCases
            )

            return
        }

        let result =
            searchEngine.search(
                query: trimmed,
                in: UtilityItem.allCases
            )

        contentView.showSearchResults(
            result
        )
    }
}

extension ToolsViewController {
    private func reloadSections(
        items: [UtilityItem]
    ) {
        
        let timeItems =
        items.filter {
            [
                .timestamp,
                .countdown,
                .timezone
            ].contains($0)
        }
        
        let dateItems =
        items.filter {
            [
                .workdays,
                .age,
                .dateDifference
            ].contains($0)
        }
        
        let calculationItems =
        items.filter {
            [
                .calculator
            ].contains($0)
        }
        
        contentView.timeSection
            .configure(
                title: "Time",
                items: timeItems
            )
        
        contentView.dateSection
            .configure(
                title: "Date",
                items: dateItems
            )
        
        contentView.calculationSection
            .configure(
                title: "Calculation",
                items: calculationItems
            )
    }
}

extension ToolsViewController:
    UITextFieldDelegate {
    
    func textFieldShouldReturn(
        _ textField: UITextField
    ) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
    }
}
