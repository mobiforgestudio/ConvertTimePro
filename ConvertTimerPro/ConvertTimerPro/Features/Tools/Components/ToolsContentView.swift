//
//  ToolsContentView.swift
//  ConvertTimerPro
//
//  Created by Mac Mini on 30/5/26.
//

import UIKit
import SnapKit
import Then

final class ToolsContentView:
    BaseView {
    
    let timeSection =
    UtilitySectionView()
    
    let dateSection =
    UtilitySectionView()
    
    let calculationSection =
    UtilitySectionView()
    
    private let scrollView =
    UIScrollView()
    
    private let contentView =
    UIView()
    
    let searchTextField =
    UITextField().then {
        
        $0.attributedPlaceholder =
        NSAttributedString(
            string: "Search utilities",
            attributes: [
                .foregroundColor:
                    AppColor.Text.secondary
                    .withAlphaComponent(0.8)
            ]
        )
        
        $0.font =
        AppFont.bodyMedium()
        
        $0.textColor =
        AppColor.Text.primary
        
        $0.backgroundColor =
        AppColor.Surface.card
        
        $0.layer.cornerRadius =
        18
        
        $0.clearButtonMode =
            .whileEditing
        
        $0.returnKeyType =
            .search
        
        $0.autocorrectionType =
            .no
        
        $0.autocapitalizationType =
            .none
        
        $0.leftView =
        makeSearchLeftView()
        
        $0.leftViewMode =
            .always
        
        func makeSearchLeftView() -> UIView {
            
            let container =
            UIView(
                frame: CGRect(
                    x: 0,
                    y: 0,
                    width: 56,
                    height: 52
                )
            )
            
            let imageView =
            UIImageView(
                image: UIImage(
                    systemName: "magnifyingglass"
                )
            )
            
            imageView.tintColor =
            AppColor.Text.secondary
            
            imageView.frame =
            CGRect(
                x: 16,
                y: 17,
                width: 18,
                height: 18
            )
            
            container.addSubview(
                imageView
            )
            
            return container
        }
    }
    
    let searchResultSection =
    UtilitySectionView()
    
    private let emptyLabel =
    UILabel().then {
        
        $0.text =
        """
        No utilities found
        Try searching with another keyword
        """
        
        $0.font =
        AppFont.bodyMedium()
        
        $0.textColor =
        AppColor.Text.secondary
        
        $0.textAlignment =
            .center
        
        $0.isHidden =
        true
    }
    
    private let stackView =
    UIStackView().then {
        
        $0.axis = .vertical
        
        $0.spacing = 24
    }
    
    override func setupView() {
        
        backgroundColor =
        AppColor.Background.primary
        
        searchResultSection.isHidden =
        true
        addSubview(scrollView)
        
        scrollView.addSubview(
            contentView
        )
        
        contentView.addSubview(
            stackView
        )
        
        let title =
        UILabel()
        
        title.text =
        "Tools"
        
        title.font =
        AppFont.largeTitle()
        
        title.textColor =
        AppColor.Text.primary
        
        let subtitle =
        UILabel()
        
        subtitle.text =
        "All utilities in one place"
        
        subtitle.font =
        AppFont.bodyMedium()
        
        subtitle.textColor =
        AppColor.Text.secondary
        
        stackView.addArrangedSubview(
            title
        )
        
        stackView.addArrangedSubview(
            subtitle
        )
        
        stackView.addArrangedSubview(
            searchTextField
        )
        
        stackView.addArrangedSubview(
            searchResultSection
        )
        
        stackView.addArrangedSubview(
            emptyLabel
        )
        
        stackView.addArrangedSubview(
            timeSection
        )
        
        stackView.addArrangedSubview(
            dateSection
        )
        
        stackView.addArrangedSubview(
            calculationSection
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
        
        searchTextField.snp.makeConstraints {
            
            $0.height.equalTo(48)
        }
    }
}

extension ToolsContentView {
    func showSearchResults(
        _ items: [UtilityItem]
    ) {
        
        searchResultSection
            .configure(
                title: "Search Results (\(items.count))",
                items: items
            )
        
        searchResultSection.isHidden =
        false
        
        timeSection.isHidden =
        true
        
        dateSection.isHidden =
        true
        
        calculationSection.isHidden =
        true
    }
    
    func showCategories() {
        
        searchResultSection.isHidden =
        true
        
        timeSection.isHidden =
        false
        
        dateSection.isHidden =
        false
        
        calculationSection.isHidden =
        false
        
        emptyLabel.isHidden =
        true
    }
    
    func setEmptyState(
        visible: Bool
    ) {
        
        emptyLabel.isHidden =
        !visible
    }
}
