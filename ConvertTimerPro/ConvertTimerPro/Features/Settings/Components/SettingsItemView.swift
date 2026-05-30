//
//  SettingsItemView.swift
//  ConvertTimerPro
//
//  Created by Mac Mini on 30/5/26.
//

import UIKit
import SnapKit
import Then

final class SettingsItemView:
    AppCardView {

    var onTap: (() -> Void)?

    private let iconView =
        UIImageView().then {

            $0.contentMode =
                .scaleAspectFit

            $0.tintColor =
                AppColor.Accent.primary
        }

    private let titleLabel =
        UILabel().then {

            $0.font =
                AppFont.bodyMedium()

            $0.textColor =
                AppColor.Text.primary
        }

    private let chevronImageView =
        UIImageView().then {

            $0.image =
                UIImage(
                    systemName:
                        "chevron.right"
                )

            $0.tintColor =
                AppColor.Text.secondary
        }

    override func setupView() {

        super.setupView()

        addSubview(iconView)
        addSubview(titleLabel)
        addSubview(
            chevronImageView
        )

        let tap =
            UITapGestureRecognizer(
                target: self,
                action: #selector(
                    didTap
                )
            )

        addGestureRecognizer(
            tap
        )
    }

    override func setupConstraints() {

        iconView.snp.makeConstraints {

            $0.leading.equalToSuperview()
                .offset(16)

            $0.centerY.equalToSuperview()
        }

        titleLabel.snp.makeConstraints {

            $0.leading.equalTo(
                iconView.snp.trailing
            ).offset(12)

            $0.centerY.equalToSuperview()
        }

        chevronImageView.snp.makeConstraints {

            $0.trailing.equalToSuperview()
                .offset(-16)

            $0.centerY.equalToSuperview()

            $0.size.equalTo(16)
        }
    }

    func configure(
        iconName: String,
        title: String
    ) {

        iconView.image =
        UIImage(
            systemName: iconName,
            withConfiguration:
                UIImage.SymbolConfiguration(
                    pointSize: 22,
                    weight: .medium
                )
        )

        titleLabel.text =
            title
    }

    @objc
    private func didTap() {

        onTap?()
    }
}
