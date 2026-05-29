//
//  CountdownResultCardView.swift
//  ConvertTimerPro
//
//  Created by Mac Mini on 29/5/26.
//

import UIKit
import SnapKit
import Then

final class CountdownResultCardView: BaseView {

    var onCopy: (() -> Void)?
    
    private let daysLabel = UILabel().then {
        $0.font = .systemFont(
            ofSize: 56,
            weight: .bold
        )

        $0.textColor =
            AppColor.Text.primary

        $0.textAlignment = .center

        $0.text = "-- Days"
    }

    private let subtitleLabel = UILabel().then {
        $0.font = AppFont.bodyMedium()

        $0.textColor =
            AppColor.Text.secondary

        $0.textAlignment = .center

        $0.numberOfLines = 2

        $0.text = "Select a target date"
    }

    private let dividerView = UIView().then {
        $0.backgroundColor =
            AppColor.Border.subtle
    }

    private let weeksValueLabel = UILabel().then {
        $0.font = .systemFont(
            ofSize: 24,
            weight: .semibold
        )

        $0.textColor =
            AppColor.Text.primary

        $0.textAlignment = .center
    }

    private let weeksTitleLabel = UILabel().then {
        $0.text = "Weeks"

        $0.font = AppFont.caption()

        $0.textColor =
            AppColor.Text.secondary

        $0.textAlignment = .center
    }

    private let hoursValueLabel = UILabel().then {
        $0.font = .systemFont(
            ofSize: 24,
            weight: .semibold
        )

        $0.textColor =
            AppColor.Text.primary

        $0.textAlignment = .center
    }

    private let hoursTitleLabel = UILabel().then {
        $0.text = "Hours"

        $0.font = AppFont.caption()

        $0.textColor =
            AppColor.Text.secondary

        $0.textAlignment = .center
    }

    private let countdownLabel = UILabel().then {

        $0.font = .systemFont(
            ofSize: 24,
            weight: .semibold
        )

        $0.textColor =
            AppColor.Accent.primary

        $0.textAlignment = .center

        $0.text = "--h --m --s"
    }
    
    private lazy var weeksStack =
        UIStackView(
            arrangedSubviews: [
                weeksValueLabel,
                weeksTitleLabel
            ]
        ).then {
            $0.axis = .vertical
            $0.spacing = 4
        }

    private lazy var hoursStack =
        UIStackView(
            arrangedSubviews: [
                hoursValueLabel,
                hoursTitleLabel
            ]
        ).then {
            $0.axis = .vertical
            $0.spacing = 4
        }

    private lazy var bottomStack =
        UIStackView(
            arrangedSubviews: [
                weeksStack,
                hoursStack
            ]
        ).then {
            $0.axis = .horizontal
            $0.distribution = .fillEqually
        }

    override func setupView() {

        backgroundColor =
            AppColor.Surface.card

        layer.cornerRadius = 24

        layer.borderWidth = 1

        layer.borderColor =
            AppColor.Border.subtle.cgColor

        addSubview(daysLabel)
        addSubview(subtitleLabel)
        addSubview(dividerView)
        addSubview(countdownLabel)
        addSubview(bottomStack)
        
        let tap =
            UITapGestureRecognizer(
                target: self,
                action: #selector(
                    didTapCard
                )
            )

        addGestureRecognizer(
            tap
        )

        isUserInteractionEnabled = true
        
    }

    @objc
    private func didTapCard() {

        onCopy?()
    }
    
    override func setupConstraints() {

        daysLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
                .offset(36)

            $0.leading.trailing
                .equalToSuperview()
                .inset(20)
        }

        subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(
                daysLabel.snp.bottom
            ).offset(12)

            $0.leading.trailing
                .equalToSuperview()
                .inset(20)
        }

        dividerView.snp.makeConstraints {
            $0.top.equalTo(
                subtitleLabel.snp.bottom
            ).offset(24)

            $0.leading.trailing
                .equalToSuperview()
                .inset(24)

            $0.height.equalTo(1)
        }

        countdownLabel.snp.makeConstraints {
            $0.top.equalTo(
                dividerView.snp.bottom
            ).offset(20)

            $0.leading.trailing
                .equalToSuperview()
                .inset(24)
        }

        bottomStack.snp.makeConstraints {
            $0.top.equalTo(
                countdownLabel.snp.bottom
            ).offset(20)

            $0.leading.trailing
                .equalToSuperview()
                .inset(24)

            $0.bottom.equalToSuperview()
                .offset(-24)
        }
    }
}

extension CountdownResultCardView {

    func configure(
        result: CountdownResult
    ) {

        if result.isOverdue {

            daysLabel.text =
                "\(result.days) Days Ago"

            daysLabel.textColor =
                AppColor.Semantic.warning

        } else {

            daysLabel.text =
                "\(result.days) Days"

            daysLabel.textColor =
                AppColor.Text.primary
        }

        weeksValueLabel.text =
            "\(result.weeks)"

        hoursValueLabel.text =
            NumberFormatter.localizedString(
                from: NSNumber(
                    value: result.hours
                ),
                number: .decimal
            )

        countdownLabel.text =
            String(
                format: "%02dh %02dm %02ds",
                result.remainingHours,
                result.remainingMinutes,
                result.remainingSeconds
            )
        
        if !result.eventName.isEmpty {

            subtitleLabel.text =
                result.isOverdue
                ? "\(result.eventName) has passed"
                : "Until \(result.eventName)"

        } else {

            subtitleLabel.text =
                result.isOverdue
                ? "Passed on \(formattedDate(result.targetDate))"
                : "Until \(formattedDate(result.targetDate))"
        }
    }
}

private extension CountdownResultCardView {

    func formattedDate(
        _ date: Date
    ) -> String {

        let formatter =
            DateFormatter()

        formatter.dateStyle = .medium

        return formatter.string(
            from: date
        )
    }
}
