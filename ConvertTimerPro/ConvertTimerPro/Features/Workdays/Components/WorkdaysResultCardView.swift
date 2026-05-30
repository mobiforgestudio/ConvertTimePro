//
//  WorkdaysResultCardView.swift
//  ConvertTimerPro
//
//  Created by Mac Mini on 30/5/26.
//

import UIKit
import SnapKit
import Then

final class WorkdaysResultCardView:
    AppCardView {

    private lazy var weekdayFormatter:
    DateFormatter = {

        let formatter =
            DateFormatter()

        formatter.dateFormat =
            "EEEE"

        return formatter
    }()
    
    private let dateLabel =
        UILabel().then {

            $0.font = .systemFont(
                ofSize: 36,
                weight: .bold
            )

            $0.textAlignment =
                .center

            $0.textColor =
                AppColor.Text.primary
        }

    private let weekdayLabel =
        UILabel().then {

            $0.font =
                .systemFont(
                    ofSize: 20,
                    weight: .medium
                )

            $0.textAlignment =
                .center

            $0.textColor =
                AppColor.Accent.primary
        }

    private let summaryLabel =
        UILabel().then {

            $0.font =
                AppFont.bodyMedium()

            $0.textAlignment =
                .center

            $0.textColor =
                AppColor.Text.secondary
        }

    override func setupView() {
        addSubview(dateLabel)
        addSubview(weekdayLabel)
        addSubview(summaryLabel)
    }

    override func setupConstraints() {

        dateLabel.snp.makeConstraints {

            $0.centerX.equalToSuperview()

            $0.centerY.equalToSuperview()
                .offset(-24)

            $0.leading.trailing
                .equalToSuperview()
                .inset(20)
        }

        weekdayLabel.snp.makeConstraints {

            $0.top.equalTo(
                dateLabel.snp.bottom
            ).offset(12)

            $0.leading.trailing
                .equalToSuperview()
                .inset(20)
        }

        summaryLabel.snp.makeConstraints {

            $0.top.equalTo(
                weekdayLabel.snp.bottom
            ).offset(20)

            $0.leading.trailing
                .equalToSuperview()
                .inset(20)
        }
    }

    func configure(
        result: WorkdaysResult
    ) {

        let formatter =
            DateFormatter()

        formatter.dateFormat =
            "dd MMM yyyy"

        dateLabel.text =
            formatter.string(
                from: result.targetDate
            )

        let weekday =
            Calendar.current.component(
                .weekday,
                from: result.targetDate
            )

        let isWeekend =
            weekday == 1 ||
            weekday == 7
        
        weekdayLabel.textColor =
            isWeekend
            ? AppColor.Semantic.warning
            : AppColor.Accent.primary
        
        weekdayLabel.text =
            weekdayFormatter.string(
                from: result.targetDate
            )

        summaryLabel.text =
            "+\(result.workdays) Business Days"
    }
}
