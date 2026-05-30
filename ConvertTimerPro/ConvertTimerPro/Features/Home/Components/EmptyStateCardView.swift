//
//  EmptyStateCardView.swift
//  ConvertTimerPro
//
//  Created by Mac Mini on 30/5/26.
//

import UIKit
import SnapKit
import Then

final class EmptyStateCardView:
    AppCardView {

    // MARK: - Callbacks

    var onButtonTap: (() -> Void)?

    // MARK: - Views

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

            $0.numberOfLines = 0
        }

    private let messageLabel =
        UILabel().then {

            $0.font =
                AppFont.caption()

            $0.textColor =
                AppColor.Text.secondary

            $0.numberOfLines = 0
        }

    private let actionButton =
        UIButton(
            type: .system
        ).then {

            $0.setTitleColor(
                AppColor.Accent.primary,
                for: .normal
            )

            $0.titleLabel?.font =
                AppFont.bodyMedium()

            $0.isHidden =
                true
        }

    // MARK: - Setup

    override func setupView() {

        super.setupView()

        addSubview(iconView)
        addSubview(titleLabel)
        addSubview(messageLabel)
        addSubview(actionButton)

        actionButton.addTarget(
            self,
            action: #selector(
                buttonTapped
            ),
            for: .touchUpInside
        )
    }

    override func setupConstraints() {

        iconView.snp.makeConstraints {

            $0.leading.top.equalToSuperview()
                .offset(16)

            $0.size.equalTo(32)
        }

        titleLabel.snp.makeConstraints {

            $0.top.equalToSuperview()
                .offset(16)

            $0.leading.equalTo(
                iconView.snp.trailing
            ).offset(12)

            $0.trailing.equalToSuperview()
                .offset(-16)
        }

        messageLabel.snp.makeConstraints {

            $0.top.equalTo(
                titleLabel.snp.bottom
            ).offset(6)

            $0.leading.equalTo(
                titleLabel
            )

            $0.trailing.equalToSuperview()
                .offset(-16)
        }

        actionButton.snp.makeConstraints {

            $0.top.equalTo(
                messageLabel.snp.bottom
            ).offset(12)

            $0.leading.equalTo(
                messageLabel
            )

            $0.bottom.equalToSuperview()
                .offset(-16)
        }
    }

    // MARK: - Public

    func configure(
        icon: String,
        title: String,
        message: String,
        buttonTitle: String? = nil
    ) {

        iconView.image =
            UIImage(
                systemName: icon
            )

        titleLabel.text =
            title

        messageLabel.text =
            message

        let hasButton =
            !(buttonTitle?.isEmpty ?? true)

        actionButton.isHidden =
            !hasButton

        actionButton.setTitle(
            buttonTitle,
            for: .normal
        )
    }

    // MARK: - Actions

    @objc
    private func buttonTapped() {

        HapticEngine.shared.light()

        onButtonTap?()
    }
}
