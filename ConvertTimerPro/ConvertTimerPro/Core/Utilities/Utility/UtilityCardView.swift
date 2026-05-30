//
//  UtilityCardView.swift
//  ConvertTimerPro
//
//  Created by Mac Mini on 30/5/26.
//

import UIKit
import SnapKit
import Then

final class UtilityCardView:
    AppCardView {

    var onTap: (() -> Void)?

    private let iconView =
        UIImageView().then {

            $0.tintColor =
                AppColor.Accent.primary

            $0.contentMode =
                .scaleAspectFit
        }

    private let titleLabel =
        UILabel().then {

            $0.font =
                AppFont.bodyMedium()

            $0.textColor =
                AppColor.Text.primary
        }

    private let subtitleLabel =
        UILabel().then {

            $0.font =
                AppFont.caption()

            $0.textColor =
                AppColor.Text.secondary

            $0.numberOfLines = 2
        }

    private let chevronView =
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
        addSubview(subtitleLabel)
        addSubview(chevronView)

        let tap =
            UITapGestureRecognizer(
                target: self,
                action: #selector(
                    didTapCard
                )
            )

        addGestureRecognizer(tap)
    }

    override func setupConstraints() {

        iconView.snp.makeConstraints {

            $0.leading.equalToSuperview()
                .offset(16)

            $0.centerY.equalToSuperview()

            $0.size.equalTo(24)
        }

        titleLabel.snp.makeConstraints {

            $0.top.equalToSuperview()
                .offset(16)

            $0.leading.equalTo(
                iconView.snp.trailing
            ).offset(12)

            $0.trailing.equalTo(
                chevronView.snp.leading
            ).offset(-8)
        }

        subtitleLabel.snp.makeConstraints {

            $0.top.equalTo(
                titleLabel.snp.bottom
            ).offset(4)

            $0.leading.equalTo(
                titleLabel
            )

            $0.trailing.equalTo(
                titleLabel
            )

            $0.bottom.lessThanOrEqualToSuperview()
                .offset(-16)
        }

        chevronView.snp.makeConstraints {

            $0.trailing.equalToSuperview()
                .offset(-16)

            $0.centerY.equalToSuperview()

            $0.size.equalTo(16)
        }
    }

    func configure(
        item: UtilityItem
    ) {

        titleLabel.text =
            item.title

        subtitleLabel.text =
            item.subtitle

        iconView.image =
            UIImage(
                systemName:
                    item.icon
            )
    }

    @objc
    private func didTapCard() {

        onTap?()
    }
}
