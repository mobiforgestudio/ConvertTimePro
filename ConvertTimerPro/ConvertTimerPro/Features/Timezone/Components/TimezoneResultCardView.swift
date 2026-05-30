//
//  TimezoneResultCardView.swift
//  ConvertTimerPro
//
//  Created by Mac Mini on 30/5/26.
//

import UIKit
import SnapKit
import Then

final class TimezoneResultCardView:
    AppCardView {

    private let sourceTimeLabel =
        UILabel().then {

            $0.font = .systemFont(
                ofSize: 32,
                weight: .bold
            )

            $0.textAlignment =
                .center

            $0.textColor =
                AppColor.Text.primary
        }

    private let sourceZoneLabel =
        UILabel().then {

            $0.font =
                AppFont.bodyMedium()

            $0.textAlignment =
                .center

            $0.textColor =
                AppColor.Text.secondary
        }

    private let arrowLabel =
        UILabel().then {

            $0.text = "↓"

            $0.font = .systemFont(
                ofSize: 24,
                weight: .medium
            )

            $0.textAlignment =
                .center

            $0.textColor =
                AppColor.Accent.primary
        }

    private let convertedTimeLabel =
        UILabel().then {

            $0.font = .systemFont(
                ofSize: 32,
                weight: .bold
            )

            $0.textAlignment =
                .center

            $0.textColor =
                AppColor.Text.primary
        }

    private let convertedZoneLabel =
        UILabel().then {

            $0.font =
                AppFont.bodyMedium()

            $0.textAlignment =
                .center

            $0.textColor =
                AppColor.Text.secondary
        }

    private let offsetLabel =
        UILabel().then {

            $0.font =
                AppFont.bodyMedium()

            $0.textAlignment =
                .center

            $0.textColor =
                AppColor.Accent.primary
        }

    private lazy var timeFormatter:
        DateFormatter = {

            let formatter =
                DateFormatter()

            formatter.dateFormat =
                "HH:mm"

            return formatter
        }()

    override func setupView() {

        super.setupView()

        addSubview(sourceTimeLabel)
        addSubview(sourceZoneLabel)
        addSubview(arrowLabel)
        addSubview(convertedTimeLabel)
        addSubview(convertedZoneLabel)
        addSubview(offsetLabel)
    }

    override func setupConstraints() {

        sourceTimeLabel.snp.makeConstraints {

            $0.top.equalToSuperview()
                .offset(20)

            $0.leading.trailing
                .equalToSuperview()
                .inset(16)
        }

        sourceZoneLabel.snp.makeConstraints {

            $0.top.equalTo(
                sourceTimeLabel.snp.bottom
            ).offset(4)

            $0.centerX.equalToSuperview()
        }

        arrowLabel.snp.makeConstraints {

            $0.top.equalTo(
                sourceZoneLabel.snp.bottom
            ).offset(8)

            $0.centerX.equalToSuperview()
        }

        convertedTimeLabel.snp.makeConstraints {

            $0.top.equalTo(
                arrowLabel.snp.bottom
            ).offset(8)

            $0.leading.trailing
                .equalToSuperview()
                .inset(16)
        }

        convertedZoneLabel.snp.makeConstraints {

            $0.top.equalTo(
                convertedTimeLabel.snp.bottom
            ).offset(4)

            $0.centerX.equalToSuperview()
        }

        offsetLabel.snp.makeConstraints {

            $0.top.equalTo(
                convertedZoneLabel.snp.bottom
            ).offset(8)

            $0.centerX.equalToSuperview()
        }
    }

    func configure(
        result: TimezoneResult
    ) {

        sourceTimeLabel.text =
            timeFormatter.string(
                from: result.sourceDate
            )

        convertedTimeLabel.text =
            timeFormatter.string(
                from: result.convertedDate
            )

        sourceZoneLabel.text =
            displayName(
                for: result.fromTimeZone
            )

        convertedZoneLabel.text =
            displayName(
                for: result.toTimeZone
            )

        let offset =
            result.offsetHours

        offsetLabel.text =
            offset >= 0
            ? "+\(offset) Hours"
            : "\(offset) Hours"
    }
    
    private func displayName(
        for timeZone: TimeZone
    ) -> String {

        let offset =
            timeZone.secondsFromGMT()

        let hours =
            offset / 3600

        if hours == 0 {
            return "UTC"
        }

        return hours > 0
            ? "GMT+\(hours)"
            : "GMT\(hours)"
    }
}
