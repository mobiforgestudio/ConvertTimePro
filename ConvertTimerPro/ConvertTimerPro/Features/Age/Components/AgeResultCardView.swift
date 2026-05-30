//
//  AgeResultCardView.swift
//  ConvertTimerPro
//
//  Created by Mac Mini on 30/5/26.
//

import UIKit
import SnapKit
import Then

final class AgeResultCardView:
    AppCardView {
    
    private let iconLabel = UILabel().then {
        
        $0.text = "🎂"
        
        $0.font = .systemFont(
            ofSize: 36
        )
        
        $0.textAlignment = .center
    }
    
    private let ageLabel = UILabel().then {
        
        $0.font = .systemFont(
            ofSize: 64,
            weight: .bold
        )
        
        $0.textAlignment = .center
        
        $0.textColor =
        AppColor.Accent.primary
        
    }
    
    private let yearsLabel = UILabel().then {
        
        $0.text = "Years"
        
        $0.font =
        AppFont.bodyMedium()
        
        $0.textAlignment = .center
        
        $0.textColor =
        AppColor.Text.secondary
    }
    
    private let dividerTop = UIView().then {
        
        $0.backgroundColor =
        AppColor.Border.subtle
    }
    
    private let monthDayLabel = UILabel().then {
        
        $0.font =
        AppFont.bodyMedium()
        
        $0.textAlignment = .center
        
        $0.textColor =
        AppColor.Text.secondary
    }
    
    private let nextBirthdayLabel =
        UILabel().then {

            $0.font =
                AppFont.bodyMedium()

            $0.textAlignment =
                .center

            $0.textColor =
                AppColor.Accent.primary

            $0.numberOfLines = 0
        }
    
    private let dividerBottom = UIView().then {
        
        $0.backgroundColor =
        AppColor.Border.subtle
    }
    
    private let statsStack =
    UIStackView().then {
        
        $0.axis = .vertical
        
        $0.spacing = 12
    }
    
    override func setupView() {
        
        super.setupView()
        
        addSubview(iconLabel)
        addSubview(ageLabel)
        addSubview(yearsLabel)
        addSubview(dividerTop)
        addSubview(monthDayLabel)
        addSubview(nextBirthdayLabel)
        addSubview(dividerBottom)
        addSubview(statsStack)
    }
    
    override func setupConstraints() {
        
        iconLabel.snp.makeConstraints {
            
            $0.top.equalToSuperview()
                .offset(24)
            
            $0.centerX.equalToSuperview()
        }
        
        ageLabel.snp.makeConstraints {
            
            $0.top.equalTo(
                iconLabel.snp.bottom
            ).offset(8)
            
            $0.leading.trailing
                .equalToSuperview()
                .inset(16)
        }
        
        yearsLabel.snp.makeConstraints {
            
            $0.top.equalTo(
                ageLabel.snp.bottom
            ).offset(4)
            
            $0.centerX.equalToSuperview()
        }
        
        dividerTop.snp.makeConstraints {
            
            $0.top.equalTo(
                yearsLabel.snp.bottom
            ).offset(20)
            
            $0.leading.trailing
                .equalToSuperview()
                .inset(24)
            
            $0.height.equalTo(1)
        }
        
        monthDayLabel.snp.makeConstraints {
            
            $0.top.equalTo(
                dividerTop.snp.bottom
            ).offset(16)
            
            $0.leading.trailing
                .equalToSuperview()
                .inset(16)
        }
    
        nextBirthdayLabel.snp.makeConstraints {

            $0.top.equalTo(
                monthDayLabel.snp.bottom
            ).offset(16)

            $0.leading.trailing
                .equalToSuperview()
                .inset(16)
        }

        dividerBottom.snp.makeConstraints {

            $0.top.equalTo(
                nextBirthdayLabel.snp.bottom
            ).offset(16)

            $0.leading.trailing
                .equalToSuperview()
                .inset(24)

            $0.height.equalTo(1)
        }
        
        statsStack.snp.makeConstraints {
            
            $0.top.equalTo(
                dividerBottom.snp.bottom
            ).offset(20)
            
            $0.leading.trailing
                .equalToSuperview()
                .inset(24)
            
            $0.bottom.lessThanOrEqualToSuperview()
                .offset(-24)
        }
    }
    
    private func makeRow(
        title: String,
        value: String
    ) -> UIStackView {
        
        let left = UILabel()
        
        left.text = title
        
        left.font =
        AppFont.bodyMedium()
        
        left.textColor =
        AppColor.Text.secondary
        
        let right = UILabel()
        
        right.text = value
        
        right.font =
        AppFont.bodyMedium()
        
        right.textAlignment = .right
        
        right.textColor =
        AppColor.Text.primary
        
        let spacer = UIView()
        
        let stack = UIStackView(
            arrangedSubviews: [
                left,
                spacer,
                right
            ]
        )
        
        stack.axis = .horizontal
        
        return stack
    }
    
    func configure(
        result: AgeResult
    ) {
        
        ageLabel.text =
        "\(result.years)"
        
        monthDayLabel.text =
        "\(result.months) Months • \(result.days) Days"
        
        statsStack.arrangedSubviews.forEach {
            
            statsStack.removeArrangedSubview($0)
            
            $0.removeFromSuperview()
        }
        
        nextBirthdayLabel.text =
        """
        🎉 Next Birthday

        in \(result.nextBirthdayDaysRemaining) days
        """
        
        statsStack.addArrangedSubview(
            makeRow(
                title: "📅 Days",
                value: result.totalDays.formatted()
            )
        )
        
        statsStack.addArrangedSubview(
            makeRow(
                title: "⏰ Hours",
                value: result.totalHours.formatted()
            )
        )
        
        statsStack.addArrangedSubview(
            makeRow(
                title: "⌛ Minutes",
                value: result.totalMinutes.formatted()
            )
        )
    }
}
