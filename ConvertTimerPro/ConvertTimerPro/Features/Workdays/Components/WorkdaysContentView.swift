//
//  WorkdaysContentView.swift
//  ConvertTimerPro
//
//  Created by Mac Mini on 30/5/26.
//

import UIKit
import SnapKit
import Then

final class WorkdaysContentView: BaseView {
    
    let titleLabel = UILabel().then {
        $0.text = "Workdays"
        $0.font = AppFont.largeTitle()
        $0.textColor = AppColor.Text.primary
    }
    
    private let subtitleLabel = UILabel().then {
        
        $0.text =
        "Calculate future dates using business days"
        
        $0.font =
        AppFont.bodyMedium()
        
        $0.textColor =
        AppColor.Text.secondary
        
        $0.numberOfLines = 0
    }
    
    let dateInputView =
    AppDateFieldView()
    
    let workdaysLabel = UILabel().then {
        $0.text = "Workdays"
        $0.font = AppFont.caption()
        $0.textColor = AppColor.Text.secondary
    }
    
    let stepperView = WorkdaysStepperView()
    
    let quickChipsView =
    WorkdaysQuickChipsView()
    
    let resultCardView =
    WorkdaysResultCardView()
    
    private let scrollView = UIScrollView()
    
    private let contentContainer = UIView()
    
    private let stackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 20
    }
    
    override func setupView() {
        
        backgroundColor =
        AppColor.Background.primary
        
        addSubview(scrollView)
        
        scrollView.addSubview(
            contentContainer
        )
        
        contentContainer.addSubview(
            stackView
        )
        
        stackView.addArrangedSubview(
            titleLabel
        )
        
        stackView.addArrangedSubview(
            subtitleLabel
        )
        
        stackView.addArrangedSubview(
            dateInputView
        )
        
        stackView.addArrangedSubview(
            workdaysLabel
        )
        
        stackView.addArrangedSubview(
            stepperView
        )
        
        stackView.addArrangedSubview(
            quickChipsView
        )
        
        stackView.addArrangedSubview(
            resultCardView
        )
    }
    
    override func setupConstraints() {
        
        scrollView.snp.makeConstraints {
            $0.edges.equalTo(
                safeAreaLayoutGuide
            )
        }
        
        contentContainer.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }
        
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
                .inset(
                    UIEdgeInsets(
                        top: 16,
                        left: 16,
                        bottom: 32,
                        right: 16
                    )
                )
        }
        
        quickChipsView.snp.makeConstraints {
            $0.height.equalTo(40)
        }
        
        stepperView.snp.makeConstraints {
            $0.height.equalTo(60)
        }
        
        resultCardView.snp.makeConstraints {
            $0.height.equalTo(180)
        }
    }
}
