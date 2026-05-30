//
//  AppDateFieldView.swift
//  ConvertTimerPro
//
//  Created by Mac Mini on 30/5/26.
//

import UIKit
import SnapKit
import Then

final class AppDateFieldView:
    AppCardView {

    var onTap: (() -> Void)?

    private let titleLabel = UILabel().then {

        $0.font =
            AppFont.caption()

        $0.textColor =
            AppColor.Text.secondary
    }

    private let iconView = UIImageView().then {

        $0.image =
            UIImage(
                systemName: "calendar"
            )

        $0.tintColor =
            AppColor.Accent.primary

        $0.contentMode =
            .scaleAspectFit
    }

    private let valueLabel = UILabel().then {

        $0.font =
            AppFont.bodyMedium()

        $0.textColor =
            AppColor.Text.primary
    }

    private lazy var formatter:
        DateFormatter = {

            let formatter =
                DateFormatter()

            formatter.dateStyle =
                .medium

            return formatter
        }()

    override func setupView() {

        super.setupView()

        addSubview(titleLabel)

        addSubview(iconView)

        addSubview(valueLabel)

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

        iconView.snp.makeConstraints {
            $0.leading.equalToSuperview()
                .offset(16)

            $0.top.equalTo(
                titleLabel.snp.bottom
            ).offset(12)

            $0.size.equalTo(20)

            $0.bottom.equalToSuperview()
                .offset(-16)
        }

        valueLabel.snp.makeConstraints {
            $0.centerY.equalTo(
                iconView
            )

            $0.leading.equalTo(
                iconView.snp.trailing
            ).offset(12)

            $0.trailing.equalToSuperview()
                .offset(-16)
        }
    }

    func configure(
        title: String,
        date: Date
    ) {

        titleLabel.text =
            title

        valueLabel.text =
            formatter.string(
                from: date
            )
    }

    @objc
    private func didTapView() {

        onTap?()
    }
}
