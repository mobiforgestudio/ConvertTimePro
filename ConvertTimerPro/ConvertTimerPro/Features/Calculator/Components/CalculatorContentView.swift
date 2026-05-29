//
//  CalculatorContentView.swift
//  ConvertTimerPro
//
//  Created by Mac Mini on 27/5/26.
//

import UIKit
import SnapKit
import Then

final class CalculatorContentView: BaseView {

    // MARK: - Views

    let scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
        $0.alwaysBounceVertical = true
        $0.keyboardDismissMode = .interactive
        $0.contentInsetAdjustmentBehavior = .never
    }

    private let containerView = UIView()

    private let contentStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = AppSpacing.xl
    }

    // MARK: - Header

    private let titleLabel = UILabel().then {
        $0.text = "Calculator"
        $0.font = AppFont.largeTitle()
        $0.textColor = AppColor.Text.primary
    }

    // MARK: - Expression

    let expressionInputView =
        ExpressionInputView()

    // MARK: - Suggestions

    private let suggestionContainerView =
        UIView()

    let suggestionScrollView = UIScrollView().then {
        $0.showsHorizontalScrollIndicator = false
        $0.alwaysBounceHorizontal = true
        $0.contentInsetAdjustmentBehavior = .never
    }

    private let suggestionContentView = UIView()

    let suggestionStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = AppSpacing.sm
        $0.alignment = .fill
        $0.distribution = .fill
    }

    let autocompleteStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = AppSpacing.sm
        $0.alignment = .fill
        $0.distribution = .fill
    }
    
    // MARK: - Result

    let resultCardView =
        ResultCardView()

    // MARK: - Breakdown

    let breakdownContainerView =
        BreakdownView()

    // MARK: - History
    
    let historySectionView = RecordsSectionView()
    
    let favoritesSectionView = RecordsSectionView()
    
    // MARK: - Setup

    override func setupView() {

        addSubview(scrollView)

        scrollView.addSubview(containerView)

        containerView.addSubview(contentStackView)

        // MARK: - Stack Content

        contentStackView.addArrangedSubview(
            titleLabel
        )

        contentStackView.addArrangedSubview(
            expressionInputView
        )

        contentStackView.addArrangedSubview(
            autocompleteStackView
        )
        
        contentStackView.addArrangedSubview(
            suggestionContainerView
        )

        contentStackView.addArrangedSubview(
            resultCardView
        )

        contentStackView.addArrangedSubview(
            breakdownContainerView
        )

        contentStackView.addArrangedSubview(
            favoritesSectionView
        )
        
        contentStackView.addArrangedSubview(
            historySectionView
        )
        
        // MARK: - Suggestion

        suggestionContainerView.addSubview(
            suggestionScrollView
        )

        suggestionScrollView.addSubview(
            suggestionContentView
        )

        suggestionContentView.addSubview(
            suggestionStackView
        )
    }

    override func setupConstraints() {

        // MARK: - Scroll

        scrollView.snp.makeConstraints {
            $0.edges.equalTo(safeAreaLayoutGuide)
        }

        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }

        contentStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
                .inset(AppSpacing.xl)
        }

        // MARK: - Expression

        expressionInputView.snp.makeConstraints {
            $0.height.equalTo(96)
        }

        autocompleteStackView.snp.makeConstraints {
            $0.height.equalTo(36)
        }
        
        // MARK: - Suggestion Container

        suggestionContainerView.snp.makeConstraints {
            $0.height.equalTo(44)
        }

        suggestionScrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        suggestionContentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalToSuperview()
        }

        suggestionStackView.snp.makeConstraints {

            $0.top.bottom.equalToSuperview()

            $0.left.equalToSuperview()
                .offset(AppSpacing.xs)

            $0.right.equalToSuperview()
                .offset(-AppSpacing.xs)

            $0.height.equalToSuperview()
        }

        // MARK: - Result

        resultCardView.snp.makeConstraints {
            $0.height.equalTo(220)
        }
    }

    override func setupStyle() {

        backgroundColor =
            AppColor.Background.primary
    }
}
