//
//  CountdownResultCardView.swift
//  ConvertTimerPro
//
//  Created by Mac Mini on 29/5/26.
//

import UIKit
import SnapKit
import Then

final class CountdownResultCardView: AppCardView {

    var onCopy: (() -> Void)?

    private let daysLabel = UILabel().then {
        $0.font = .systemFont(
            ofSize: 56,
            weight: .bold
        )

        $0.textColor =
            AppColor.Text.primary

        $0.textAlignment = .center
    }

    private let subtitleLabel = UILabel().then {
        $0.font =
            AppFont.bodyMedium()

        $0.textColor =
            AppColor.Text.secondary

        $0.textAlignment = .center

        $0.numberOfLines = 2
    }

    private let dividerView = UIView().then {
        $0.backgroundColor =
            AppColor.Border.subtle
    }

    private let countdownLabel = UILabel().then {

        $0.font = .systemFont(
            ofSize: 28,
            weight: .semibold
        )

        $0.textColor =
            AppColor.Accent.primary

        $0.textAlignment = .center
    }

    override func setupView() {

        addSubview(daysLabel)

        addSubview(subtitleLabel)

        addSubview(dividerView)

        addSubview(countdownLabel)

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

    override func setupConstraints() {

        daysLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
                .offset(32)

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
            ).offset(24)

            $0.leading.trailing
                .equalToSuperview()
                .inset(20)

            $0.bottom.equalToSuperview()
                .offset(-32)
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

        countdownLabel.text =
            String(
                format: "%02dh %02dm %02ds",
                result.remainingHours,
                result.remainingMinutes,
                result.remainingSeconds
            )
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

    @objc
    func didTapCard() {

        onCopy?()
    }
}
