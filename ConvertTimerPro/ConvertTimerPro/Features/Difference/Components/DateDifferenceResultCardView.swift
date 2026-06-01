//
//  DateDifferenceResultCardView.swift
//  ConvertTimerPro
//
//  Created by Mac Mini on 30/5/26.
//

import UIKit
import SnapKit
import Then

final class DateDifferenceResultCardView: AppCardView {
    
    private let heroValueLabel = UILabel().then {
        $0.font = .systemFont(
            ofSize: 64,
            weight: .bold
        )
        $0.textAlignment = .center
        $0.textColor = AppColor.Accent.primary
    }
    
    private let heroTitleLabel = UILabel().then {
        $0.font = AppFont.bodyMedium()
        $0.textAlignment = .center
        $0.textColor = AppColor.Text.secondary
    }
    
    private let dividerTop = UIView().then {
        $0.backgroundColor = AppColor.Border.subtle
    }
    
    private let summaryLabel = UILabel().then {
        $0.font = AppFont.bodyMedium()
        $0.textAlignment = .center
        $0.textColor = AppColor.Text.primary
    }
    
    private let dividerBottom = UIView().then {
        $0.backgroundColor = AppColor.Border.subtle
    }
    
    private let statsStack = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 12
    }
    
    override func setupView() {
        
        super.setupView()
        
        addSubview(heroValueLabel)
        addSubview(heroTitleLabel)
        
        addSubview(dividerTop)
        addSubview(summaryLabel)
        addSubview(dividerBottom)
        
        addSubview(statsStack)
    }
    
    override func setupConstraints() {
        
        heroValueLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
                .offset(24)
            
            $0.leading.trailing
                .equalToSuperview()
                .inset(16)
        }
        
        heroTitleLabel.snp.makeConstraints {
            $0.top.equalTo(
                heroValueLabel.snp.bottom
            ).offset(4)
            
            $0.centerX.equalToSuperview()
        }
        
        dividerTop.snp.makeConstraints {
            $0.top.equalTo(
                heroTitleLabel.snp.bottom
            ).offset(20)
            
            $0.leading.trailing
                .equalToSuperview()
                .inset(24)
            
            $0.height.equalTo(1)
        }
        
        summaryLabel.snp.makeConstraints {
            $0.top.equalTo(
                dividerTop.snp.bottom
            ).offset(16)
            
            $0.leading.trailing
                .equalToSuperview()
                .inset(16)
        }
        
        dividerBottom.snp.makeConstraints {
            $0.top.equalTo(
                summaryLabel.snp.bottom
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
        icon: String,
        title: String,
        value: String
    ) -> UIStackView {

        let iconView =
            UIImageView().then {

                $0.image =
                    UIImage(
                        systemName: icon
                    )

                $0.tintColor =
                    AppColor.Accent.primary

                $0.contentMode =
                    .scaleAspectFit
            }

        iconView.snp.makeConstraints {

            $0.width.height.equalTo(
                18
            )
        }

        let titleLabel =
            UILabel()

        titleLabel.text =
            title

        titleLabel.font =
            AppFont.bodyMedium()

        titleLabel.textColor =
            AppColor.Text.secondary

        let leftStack =
            UIStackView(
                arrangedSubviews: [
                    iconView,
                    titleLabel
                ]
            )

        leftStack.axis =
            .horizontal

        leftStack.spacing = 8

        let valueLabel =
            UILabel()

        valueLabel.text =
            value

        valueLabel.font =
            .monospacedDigitSystemFont(
                ofSize: 18,
                weight: .medium
            )

        valueLabel.textAlignment =
            .right

        valueLabel.textColor =
            AppColor.Text.primary

        let spacer =
            UIView()

        let row =
            UIStackView(
                arrangedSubviews: [
                    leftStack,
                    spacer,
                    valueLabel
                ]
            )

        row.axis =
            .horizontal

        return row
    }
    
    func configure(
        result: DateDifferenceResult
    ) {

        if result.totalDays == 0 {

            heroValueLabel.text = "0"

            heroTitleLabel.text = "Days"

            summaryLabel.text =
                "Same Date"

        } else if result.years > 0 {

            heroValueLabel.text =
                "\(result.years)"

            heroTitleLabel.text =
                result.years == 1
                ? "Year"
                : "Years"

            summaryLabel.text =
            """
            \(PluralFormatter.format(
                result.months,
                singular: "Month",
                plural: "Months"
            ))
            •
            \(PluralFormatter.format(
                result.days,
                singular: "Day",
                plural: "Days"
            ))
            """

        } else {

            heroValueLabel.text =
                "\(result.totalDays)"

            heroTitleLabel.text =
                result.totalDays == 1
                ? "Day"
                : "Days"

            summaryLabel.text =
            """
            \(PluralFormatter.format(
                result.months,
                singular: "Month",
                plural: "Months"
            ))
            •
            \(PluralFormatter.format(
                result.days,
                singular: "Day",
                plural: "Days"
            ))
            """
        }

        statsStack.arrangedSubviews.forEach {

            statsStack.removeArrangedSubview(
                $0
            )

            $0.removeFromSuperview()
        }

        statsStack.addArrangedSubview(
            makeRow(
                icon: "calendar",
                title: "Days",
                value:
                    result.totalDays.formatted()
            )
        )

        statsStack.addArrangedSubview(
            makeRow(
                icon:
                    "calendar.badge.clock",
                title: "Weeks",
                value:
                    result.totalWeeks.formatted()
            )
        )

        statsStack.addArrangedSubview(
            makeRow(
                icon: "clock",
                title: "Hours",
                value:
                    result.totalHours.formatted()
            )
        )

        statsStack.addArrangedSubview(
            makeRow(
                icon: "timer",
                title: "Minutes",
                value:
                    result.totalMinutes.formatted()
            )
        )
    }
    
    func plural(
        _ value: Int,
        singular: String,
        plural: String
    ) -> String {
        
        value == 1
        ? "\(value) \(singular)"
        : "\(value) \(plural)"
    }
}
