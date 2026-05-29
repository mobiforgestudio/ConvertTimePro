//
//  ResultCardView.swift
//  ConvertTimerPro
//
//  Created by Mac Mini on 27/5/26.
//

import UIKit
import SnapKit
import Then

final class ResultCardView: BaseView {

    // MARK: - Views

    private let cardView = GlassCardView()

    private let contentStackView = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .center
        $0.spacing = AppSpacing.sm
    }

    private let resultLabel = UILabel().then {
        $0.font = AppFont.hero()
        $0.textColor = AppColor.Text.primary
        $0.textAlignment = .center
        $0.numberOfLines = 1
        $0.adjustsFontSizeToFitWidth = true
        $0.minimumScaleFactor = 0.7
    }

    private let subtitleLabel = UILabel().then {
        $0.font = AppFont.bodyMedium()
        $0.textColor = AppColor.Text.secondary
        $0.textAlignment = .center
        $0.numberOfLines = 1
    }

    private let detailLabel = UILabel().then {
        $0.font = AppFont.caption()
        $0.textColor = AppColor.Text.tertiary
        $0.textAlignment = .center
        $0.numberOfLines = 1
    }

    // MARK: - Setup

    override func setupView() {

        addSubview(cardView)

        cardView.contentView.addSubview(
            contentStackView
        )

        contentStackView.addArrangedSubview(
            resultLabel
        )

        contentStackView.addArrangedSubview(
            subtitleLabel
        )

        contentStackView.addArrangedSubview(
            detailLabel
        )
    }

    override func setupConstraints() {

        cardView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        contentStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
                .inset(AppSpacing.xxl)
        }
    }

    override func setupStyle() {

        backgroundColor = .clear
    }
}

// MARK: - Public

extension ResultCardView {

    func configure(
        with model: ResultViewModel,
        animated: Bool = true
    ) {

        let updateContent = {

            self.resultLabel.text =
                model.timeText

            self.subtitleLabel.text =
                model.dateText

            self.detailLabel.text =
                model.expressionText
        }

        guard animated else {

            updateContent()

            return
        }

        UIView.animate(
            withDuration: 0.12,
            animations: {

                self.resultLabel.alpha = 0.7
                self.subtitleLabel.alpha = 0.7
                self.detailLabel.alpha = 0.7

                self.resultLabel.transform =
                    CGAffineTransform(
                        scaleX: 0.98,
                        y: 0.98
                    )

                self.subtitleLabel.transform =
                    CGAffineTransform(
                        scaleX: 0.98,
                        y: 0.98
                    )

                self.detailLabel.transform =
                    CGAffineTransform(
                        scaleX: 0.98,
                        y: 0.98
                    )
            },
            completion: { _ in

                updateContent()

                UIView.animate(
                    withDuration: 0.18,
                    delay: 0,
                    options: [
                        .curveEaseInOut
                    ],
                    animations: {

                        self.resultLabel.alpha = 1
                        self.subtitleLabel.alpha = 1
                        self.detailLabel.alpha = 1

                        self.resultLabel.transform =
                            .identity

                        self.subtitleLabel.transform =
                            .identity

                        self.detailLabel.transform =
                            .identity
                    }
                )
            }
        )
    }
}
