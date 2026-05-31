//
//  TimestampClipboardBannerView.swift
//  ConvertTimerPro
//
//  Created by Mac Mini on 29/5/26.
//

import UIKit
import SnapKit
import Then

final class TimestampClipboardBannerView: BaseView {

    var onConvert: (() -> Void)?

    private let titleLabel = UILabel().then {
        $0.text = "Detected Timestamp"
        $0.font = AppFont.bodyMedium()
        $0.textColor = AppColor.Text.primary
    }

    private let valueLabel = UILabel().then {
        $0.font = AppFont.caption()
        $0.textColor = AppColor.Text.secondary
        $0.numberOfLines = 1
    }

    private let convertButton = UIButton(type: .system).then {
        $0.setTitle(
            "Convert",
            for: .normal
        )

        $0.setTitleColor(
            AppColor.Accent.primary,
            for: .normal
        )

        $0.titleLabel?.font =
            AppFont.bodyMedium()
    }

    override func setupView() {

        backgroundColor =
            AppColor.Surface.elevated

        layer.cornerRadius = 16

        layer.borderWidth = 1

        layer.borderColor =
            AppColor.Border.subtle.cgColor

        addSubview(titleLabel)
        addSubview(valueLabel)
        addSubview(convertButton)
    }

    override func setupConstraints() {

        convertButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview()
                .offset(-16)
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
                .offset(12)

            $0.leading.equalToSuperview()
                .offset(16)

            $0.trailing.lessThanOrEqualTo(
                convertButton.snp.leading
            ).offset(-12)
        }

        valueLabel.snp.makeConstraints {
            $0.top.equalTo(
                titleLabel.snp.bottom
            ).offset(4)

            $0.leading.equalTo(
                titleLabel
            )

            $0.trailing.lessThanOrEqualTo(
                convertButton.snp.leading
            ).offset(-12)

            $0.bottom.equalToSuperview()
                .offset(-12)
        }
    }

    override func bind() {

        convertButton.addTarget(
            self,
            action: #selector(
                didTapConvert
            ),
            for: .touchUpInside
        )
    }

    func configure(
        value: String
    ) {

        valueLabel.text = value
    }

    @objc
    private func didTapConvert() {

        onConvert?()
    }
}
