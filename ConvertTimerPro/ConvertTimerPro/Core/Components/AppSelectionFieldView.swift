//
//  AppSelectionFieldView.swift
//  ConvertTimerPro
//
//  Created by Mac Mini on 30/5/26.
//

import UIKit
import SnapKit
import Then

final class AppSelectionFieldView:
    AppCardView {

    var onTap: (() -> Void)?

    private let titleLabel = UILabel().then {

        $0.font =
            AppFont.caption()

        $0.textColor =
            AppColor.Text.secondary
    }

    private let valueLabel = UILabel().then {

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
                        "chevron.down"
                )

            $0.tintColor =
                AppColor.Text.secondary

            $0.contentMode =
                .scaleAspectFit
        }

    override func setupView() {

        super.setupView()

        addSubview(titleLabel)
        addSubview(valueLabel)
        addSubview(
            chevronImageView
        )

        let tap =
            UITapGestureRecognizer(
                target: self,
                action: #selector(
                    didTapView
                )
            )

        addGestureRecognizer(
            tap
        )
    }

    override func setupConstraints() {

        titleLabel.snp.makeConstraints {

            $0.top.equalToSuperview()
                .offset(16)

            $0.leading.trailing
                .equalToSuperview()
                .inset(16)
        }

        valueLabel.snp.makeConstraints {

            $0.leading.equalToSuperview()
                .offset(16)

            $0.top.equalTo(
                titleLabel.snp.bottom
            ).offset(12)

            $0.bottom.equalToSuperview()
                .offset(-16)
        }

        chevronImageView.snp.makeConstraints {

            $0.trailing.equalToSuperview()
                .offset(-16)

            $0.centerY.equalTo(
                valueLabel
            )

            $0.size.equalTo(16)
        }
    }

    func configure(
        title: String,
        value: String
    ) {

        titleLabel.text =
            title

        valueLabel.text =
            value
    }

    @objc
    private func didTapView() {

        onTap?()
    }
}
