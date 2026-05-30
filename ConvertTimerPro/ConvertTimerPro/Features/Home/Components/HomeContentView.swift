//
//  HomeContentView.swift
//  ConvertTimerPro
//
//  Created by Mac Mini on 30/5/26.
//

import UIKit
import SnapKit
import Then

final class HomeContentView: BaseView {
    
    var onUtilitySelected: ((UtilityItem) -> Void)?
    
    let recentSection =
    UtilitySectionView()
    
    let favoritesSection =
    UtilitySectionView()
    
    let favoriteEmptyCard =
    EmptyStateCardView()
    
    let recentEmptyCard =
    EmptyStateCardView()
    
    private let scrollView =
    UIScrollView()
    
    private let contentView =
    UIView()
    
    private let stackView =
    UIStackView().then {
        
        $0.axis = .vertical
        $0.spacing = 24
    }
    
    private let titleLabel =
    UILabel().then {
        
        $0.text =
        "ConvertTimer Pro"
        
        $0.font =
        AppFont.largeTitle()
        
        $0.textColor =
        AppColor.Text.primary
    }
    
    private let subtitleLabel =
    UILabel().then {
        
        $0.text =
        "Time & Productivity Utilities"
        
        $0.font =
        AppFont.bodyMedium()
        
        $0.textColor =
        AppColor.Text.secondary
    }
    
    private let countLabel =
    UILabel().then {
        $0.font =
        AppFont.caption()
        
        $0.textColor =
        AppColor.Accent.primary
    }
    
    private let quickActionsTitleLabel =
    UILabel().then {
        
        $0.text =
        "Quick Actions"
        
        $0.font =
        AppFont.bodyMedium()
        
        $0.textColor =
        AppColor.Text.primary
    }
    
    let currentTimestampButton =
    QuickActionButton(
        icon: "clock.fill",
        title: "Timestamp"
    )
    
    let today30DaysButton =
    QuickActionButton(
        icon: "calendar.badge.plus",
        title: "30 Days Later"
    )
    
    override func setupView() {
        
        backgroundColor =
        AppColor.Background.primary
        
        favoritesSection.isHidden =
        true
        
        favoriteEmptyCard.isHidden =
        false
        
        
        recentSection.isHidden =
        true
        
        recentEmptyCard.isHidden =
        false
        
        favoritesSection.showsFavoriteButton =
        false
        
        recentSection.showsFavoriteButton =
        false
        
        addSubview(scrollView)
        
        scrollView.addSubview(
            contentView
        )
        
        contentView.addSubview(
            stackView
        )
        
        stackView.addArrangedSubview(
            titleLabel
        )
        
        stackView.addArrangedSubview(
            subtitleLabel
        )
        
        stackView.addArrangedSubview(
            countLabel
        )
        
        stackView.addArrangedSubview(
            quickActionsTitleLabel
        )
        
        stackView.addArrangedSubview(
            currentTimestampButton
        )
        
        stackView.addArrangedSubview(
            today30DaysButton
        )
        
        stackView.addArrangedSubview(
            favoriteEmptyCard
        )
        
        stackView.addArrangedSubview(
            favoritesSection
        )
        
        stackView.addArrangedSubview(
            recentEmptyCard
        )
        
        stackView.addArrangedSubview(
            recentSection
        )
        
        favoritesSection.onItemSelected = {
            [weak self] item in
            
            self?.onUtilitySelected?(
                item
            )
        }
        
        recentSection.onItemSelected = {
            [weak self] item in
            
            self?.onUtilitySelected?(
                item
            )
        }
        
        favoriteEmptyCard.configure(
            icon: "star.circle.fill",
            title: "Favorite your tools",
            message: "Tap the star icon in Tools to pin your most-used utilities.",
            buttonTitle: "Browse Tools"
        )
        
        recentEmptyCard.configure(
            icon: "clock.arrow.circlepath",
            title: "No recent activity",
            message: "Open a utility to see your recent activity here."
        )
        
    }
    
    override func setupConstraints() {
        
        scrollView.snp.makeConstraints {
            
            $0.edges.equalTo(
                safeAreaLayoutGuide
            )
        }
        
        contentView.snp.makeConstraints {
            
            $0.edges.equalToSuperview()
            
            $0.width.equalToSuperview()
        }
        
        stackView.snp.makeConstraints {
            
            $0.edges.equalToSuperview()
                .inset(16)
        }
        
        [
            currentTimestampButton,
            today30DaysButton
        ].forEach {
            
            $0.snp.makeConstraints {
                
                $0.height.equalTo(56)
            }
        }
    }
    
    // MARK: - Public
    
    func configureFavorites(
        items: [UtilityItem]
    ) {
        
        let hasFavorites =
        !items.isEmpty
        
        favoritesSection.isHidden =
        !hasFavorites
        
        favoriteEmptyCard.isHidden =
        hasFavorites
        
        guard hasFavorites else {
            return
        }
        
        favoritesSection.configure(
            title: "Favorites",
            items: items
        )
    }
    
    func configureRecent(
        items: [UtilityItem]
    ) {
        
        let hasRecent =
        !items.isEmpty
        
        recentSection.isHidden =
        !hasRecent
        
        recentEmptyCard.isHidden =
        hasRecent
        
        guard hasRecent else {
            return
        }
        
        recentSection.configure(
            title: "Recently Used",
            items: items
        )
    }
    
    func updateStats(
        favoriteCount: Int
    ) {
        countLabel.text =
        "\(UtilityItem.allCases.count) Tools • \(favoriteCount) Favorites"
    }
}
