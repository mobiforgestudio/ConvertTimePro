//
//  TimestampResultCardView.swift
//  ConvertTimerPro
//
//  Created by Mac Mini on 28/5/26.
//

import UIKit
import SnapKit
import Then

final class TimestampResultCardView: BaseView {

    // MARK: - Views

    private let containerView = UIView().then {
        $0.backgroundColor =
            AppColor.Surface.glassOverlay

        $0.layer.cornerRadius = 32
        $0.layer.cornerCurve = .continuous

        $0.layer.borderWidth = 1

        $0.layer.borderColor =
            AppColor.Border.subtle
            .cgColor
    }

    private let liveDotView = UIView().then {
        $0.backgroundColor =
        AppColor.Semantic.success

        $0.layer.cornerRadius = 4
    }

    private let liveLabel = UILabel().then {
        $0.text = "Live"

        $0.font =
            AppFont.caption()

        $0.textColor =
            AppColor.Text.secondary
    }

    private let titleDateLabel = UILabel().then {
        $0.font =
            AppFont.bodyMedium()

        $0.textColor =
            AppColor.Text.secondary

        $0.textAlignment = .center

        $0.numberOfLines = 1
    }

    private let timeLabel = UILabel().then {
        $0.font =
            AppFont.hero()

        $0.textColor =
            AppColor.Text.primary

        $0.textAlignment = .center

        $0.numberOfLines = 1

        $0.adjustsFontSizeToFitWidth = true

        $0.minimumScaleFactor = 0.7
    }

    private let timezoneContainerView = UIView().then {
        $0.backgroundColor =
            AppColor.Accent.primary
            .withAlphaComponent(0.15)

        $0.layer.cornerRadius = 12
    }

    private let timezoneLabel = UILabel().then {
        $0.font =
            AppFont.caption()

        $0.textColor =
            AppColor.Accent.primary

        $0.textAlignment = .center
    }
}

// MARK: - Public

extension TimestampResultCardView {

    func configure(
        with result: TimestampResult,
        isLive: Bool
    ) {

        titleDateLabel.text =
            result.titleDate

        timeLabel.text =
            result.timeText

        timezoneLabel.text =
            result.timezoneText

        liveDotView.isHidden =
            !isLive

        liveLabel.isHidden =
            !isLive
    }
}

// MARK: - Setup

extension TimestampResultCardView {

    override func setupView() {

        backgroundColor = .clear

        addSubview(containerView)

        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        setupHeader()

        setupContent()
    }
}

// MARK: - Private

private extension TimestampResultCardView {

    func setupHeader() {

        let headerStack = UIStackView(
            arrangedSubviews: [
                liveDotView,
                liveLabel
            ]
        )

        headerStack.axis = .horizontal

        headerStack.alignment = .center

        headerStack.spacing = 8

        containerView.addSubview(headerStack)

        liveDotView.snp.makeConstraints {
            $0.size.equalTo(8)
        }

        headerStack.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.equalToSuperview().offset(20)
        }
    }

    func setupContent() {

        containerView.addSubview(
            titleDateLabel
        )

        containerView.addSubview(
            timeLabel
        )

        containerView.addSubview(
            timezoneContainerView
        )

        timezoneContainerView.addSubview(
            timezoneLabel
        )

        titleDateLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(64)
            $0.leading.trailing.equalToSuperview().inset(24)
        }

        timeLabel.snp.makeConstraints {
            $0.top.equalTo(
                titleDateLabel.snp.bottom
            ).offset(20)

            $0.leading.trailing.equalToSuperview().inset(24)
        }

        timezoneContainerView.snp.makeConstraints {
            $0.top.equalTo(
                timeLabel.snp.bottom
            ).offset(20)

            $0.centerX.equalToSuperview()

            $0.height.equalTo(36)

            $0.bottom.equalToSuperview()
                .offset(-24)
        }

        timezoneLabel.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(
                UIEdgeInsets(
                    top: 8,
                    left: 14,
                    bottom: 8,
                    right: 14
                )
            )
        }
    }
}
