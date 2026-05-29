//
//  TimestampRepresentationRowView.swift
//  ConvertTimerPro
//
//  Created by Mac Mini on 28/5/26.
//

import UIKit
import SnapKit
import Then

final class TimestampRepresentationRowView: BaseView {

    // MARK: - Callback

    var onCopy: (() -> Void)?

    // MARK: - Views

    private let containerView = UIView().then {
        $0.backgroundColor =
            AppColor.Surface.glassOverlay

        $0.layer.cornerRadius = 20
        $0.layer.cornerCurve = .continuous

        $0.layer.borderWidth = 1

        $0.layer.borderColor =
            UIColor.white
            .withAlphaComponent(0.06)
            .cgColor
    }

    private let titleLabel = UILabel().then {
        $0.font =
            AppFont.caption()

        $0.textColor =
            AppColor.Text.secondary

        $0.numberOfLines = 1
    }

    private let valueLabel = UILabel().then {
        $0.font =
            UIFont.monospacedDigitSystemFont(
                ofSize: 16,
                weight: .medium
            )

        $0.textColor =
            AppColor.Text.primary

        $0.numberOfLines = 1

        $0.lineBreakMode =
            .byTruncatingMiddle
    }

    private let copyButton = UIButton(type: .system).then {
        $0.tintColor =
            AppColor.Accent.primary

        $0.setImage(
            UIImage(
                systemName: "doc.on.doc"
            ),
            for: .normal
        )
    }
}

// MARK: - Public

extension TimestampRepresentationRowView {

    func configure(
        with representation:
            TimestampRepresentation
    ) {

        titleLabel.text =
            representation.title

        valueLabel.text =
            representation.value
    }
}

// MARK: - Setup

extension TimestampRepresentationRowView {

    override func setupView() {

        backgroundColor = .clear

        addSubview(containerView)

        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        setupLayout()

        setupActions()
    }
}

// MARK: - Private

private extension TimestampRepresentationRowView {

    func setupLayout() {

        containerView.addSubview(
            titleLabel
        )

        containerView.addSubview(
            valueLabel
        )

        containerView.addSubview(
            copyButton
        )

        copyButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-16)
            $0.centerY.equalToSuperview()

            $0.width.height.equalTo(36)
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)

            $0.leading.equalToSuperview().offset(18)

            $0.trailing.lessThanOrEqualTo(
                copyButton.snp.leading
            ).offset(-12)
        }

        valueLabel.snp.makeConstraints {
            $0.top.equalTo(
                titleLabel.snp.bottom
            ).offset(8)

            $0.leading.equalToSuperview().offset(18)

            $0.trailing.lessThanOrEqualTo(
                copyButton.snp.leading
            ).offset(-12)

            $0.bottom.equalToSuperview().offset(-18)
        }
    }

    func setupActions() {

        copyButton.addTarget(
            self,
            action: #selector(
                didTapCopy
            ),
            for: .touchUpInside
        )
    }

    @objc
    func didTapCopy() {

        animateCopy()

        HapticEngine.shared.light()

        onCopy?()
    }

    func animateCopy() {

        UIView.animate(
            withDuration: 0.12,
            animations: {

                self.copyButton.transform =
                    CGAffineTransform(
                        scaleX: 0.82,
                        y: 0.82
                    )

                self.copyButton.alpha = 0.6
            },
            completion: { _ in

                UIView.animate(
                    withDuration: 0.18
                ) {

                    self.copyButton.transform =
                        .identity

                    self.copyButton.alpha = 1
                }
            }
        )
    }
}
