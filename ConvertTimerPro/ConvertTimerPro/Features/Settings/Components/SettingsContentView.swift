//
//  SettingsContentView.swift
//  ConvertTimerPro
//
//  Created by Mac Mini on 30/5/26.
//

import UIKit
import SnapKit
import Then

final class SettingsContentView:
    BaseView {

    let rateView =
        SettingsItemView()

    let shareView =
        SettingsItemView()

    let privacyView =
        SettingsItemView()

    let aboutView =
        SettingsItemView()

    private let titleLabel =
        UILabel().then {

            $0.text =
                "Settings"

            $0.font =
                AppFont.largeTitle()

            $0.textColor =
                AppColor.Text.primary
        }

    private let subtitleLabel =
        UILabel().then {

            $0.text =
                "Manage application preferences"

            $0.font =
                AppFont.bodyMedium()

            $0.textColor =
                AppColor.Text.secondary
        }

    let versionLabel =
        UILabel().then {

            $0.textAlignment =
                .center

            $0.font =
                AppFont.caption()

            $0.textColor =
                AppColor.Text.secondary
        }

    private let stackView =
        UIStackView().then {

            $0.axis = .vertical

            $0.spacing = 16
        }

    override func setupView() {

        backgroundColor =
            AppColor.Background.primary

        addSubview(stackView)

        stackView.addArrangedSubview(
            titleLabel
        )

        stackView.addArrangedSubview(
            subtitleLabel
        )

        stackView.addArrangedSubview(
            rateView
        )

        stackView.addArrangedSubview(
            shareView
        )

        stackView.addArrangedSubview(
            privacyView
        )

        stackView.addArrangedSubview(
            aboutView
        )

        stackView.addArrangedSubview(
            versionLabel
        )

        rateView.configure(
            iconName: "star",
            title: "Rate App"
        )

        shareView.configure(
            iconName: "square.and.arrow.up",
            title: "Share App"
        )

        privacyView.configure(
            iconName: "lock.shield",
            title: "Privacy Policy"
        )

        aboutView.configure(
            iconName: "info.circle",
            title: "About"
        )
    }

    override func setupConstraints() {

        stackView.snp.makeConstraints {

            $0.top.equalTo(
                safeAreaLayoutGuide
            ).offset(16)

            $0.leading.trailing
                .equalToSuperview()
                .inset(16)
        }

        [
            rateView,
            shareView,
            privacyView,
            aboutView
        ].forEach {

            $0.snp.makeConstraints {

                $0.height.equalTo(64)
            }
        }
    }
}
