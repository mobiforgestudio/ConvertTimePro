//
//  CountdownDateInputView.swift
//  ConvertTimerPro
//

import UIKit
import SnapKit
import Then

final class CountdownDateInputView: BaseView {

    var onTap: (() -> Void)?

    private let titleLabel = UILabel().then {
        $0.text = "Target Date"
        $0.font = AppFont.caption()
        $0.textColor = AppColor.Text.secondary
    }

    private let containerView = UIView().then {
        $0.backgroundColor =
            AppColor.Surface.input

        $0.layer.cornerRadius = 20

        $0.layer.borderWidth = 1

        $0.layer.borderColor =
            AppColor.Border.subtle.cgColor
    }

    private let valueLabel = UILabel().then {
        $0.font = AppFont.bodyMedium()
        $0.textColor = AppColor.Text.primary
        $0.text = "--"
    }

    private let iconImageView = UIImageView().then {
        $0.image = UIImage(
            systemName: "calendar"
        )

        $0.tintColor =
            AppColor.Accent.primary
    }

    override func setupView() {

        addSubview(titleLabel)

        addSubview(containerView)

        containerView.addSubview(
            valueLabel
        )

        containerView.addSubview(
            iconImageView
        )

        let tap =
            UITapGestureRecognizer(
                target: self,
                action: #selector(
                    didTap
                )
            )

        containerView.addGestureRecognizer(
            tap
        )
    }

    override func setupConstraints() {

        titleLabel.snp.makeConstraints {
            $0.top.leading.trailing
                .equalToSuperview()
        }

        containerView.snp.makeConstraints {
            $0.top.equalTo(
                titleLabel.snp.bottom
            ).offset(8)

            $0.leading.trailing.bottom
                .equalToSuperview()

            $0.height.equalTo(56)
        }

        valueLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
                .offset(16)

            $0.centerY.equalToSuperview()
        }

        iconImageView.snp.makeConstraints {
            $0.trailing.equalToSuperview()
                .offset(-16)

            $0.centerY.equalToSuperview()

            $0.size.equalTo(20)
        }
    }
}

extension CountdownDateInputView {

    func configure(
        date: Date
    ) {

        let formatter =
            DateFormatter()

        formatter.dateStyle = .medium

        valueLabel.text =
            formatter.string(
                from: date
            )
    }
}

private extension CountdownDateInputView {

    @objc
    func didTap() {

        onTap?()
    }
}
