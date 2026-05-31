//
//  UtilitySectionView.swift
//  ConvertTimerPro
//
//  Created by Mac Mini on 30/5/26.
//

import UIKit
import SnapKit
import Then
import SwiftData

final class UtilitySectionView:
    BaseView {
    
    var onItemSelected:
    ((UtilityItem) -> Void)?
    
    var onFavoriteTapped:
    ((UtilityItem) -> Void)?
    
    let favoriteStore =
        FavoriteStore(
            context:
                PersistenceController
                    .shared
                    .container
                    .mainContext
        )
    var showsFavoriteButton = true
    
    private let titleLabel =
    UILabel().then {
        
        $0.font =
        AppFont.bodyMedium()
        
        $0.textColor =
        AppColor.Text.secondary
    }
    
    private let stackView =
    UIStackView().then {
        
        $0.axis = .vertical
        
        $0.spacing = 12
    }
    
    override func setupView() {
        
        addSubview(titleLabel)
        
        addSubview(stackView)
    }
    
    override func setupConstraints() {
        
        titleLabel.snp.makeConstraints {
            
            $0.top.leading.trailing
                .equalToSuperview()
        }
        
        stackView.snp.makeConstraints {
            
            $0.top.equalTo(
                titleLabel.snp.bottom
            ).offset(12)
            
            $0.leading.trailing.bottom
                .equalToSuperview()
        }
    }
    
    func configure(
        title: String,
        items: [UtilityItem]
    ) {
        
        titleLabel.text =
        title
        
        stackView.arrangedSubviews
            .forEach {
                
                stackView.removeArrangedSubview($0)
                
                $0.removeFromSuperview()
            }
        
        items.forEach { item in

            let card =
                UtilityCardView()

            card.configure(
                item: item,
                isFavorite:
                    favoriteStore
                        .isFavorite(item),
                showsFavoriteButton:
                    showsFavoriteButton
            )

            card.onTap = {
                [weak self] in

                self?.onItemSelected?(
                    item
                )
            }

            card.onFavoriteTap = {
                [weak self] in

                self?.onFavoriteTapped?(
                    item
                )
            }

            stackView
                .addArrangedSubview(
                    card
                )

            card.snp.makeConstraints {

                $0.height.equalTo(
                    75
                )
            }
        }
    }
    
    func setVisible(
        _ visible: Bool
    ) {
        
        isHidden =
        !visible
    }
}
