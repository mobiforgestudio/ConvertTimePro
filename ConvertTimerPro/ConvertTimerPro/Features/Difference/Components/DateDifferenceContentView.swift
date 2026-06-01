//
//  DateDifferenceContentView.swift
//  ConvertTimerPro
//
//  Created by Mac Mini on 30/5/26.
//

import UIKit
import SnapKit
import Then

final class DateDifferenceContentView:
    BaseView {

    // MARK: - Header

    let titleLabel = UILabel().then {

        $0.text =
            "Date Difference"

        $0.font =
            AppFont.largeTitle()

        $0.textColor =
            AppColor.Text.primary
    }

    let subtitleLabel = UILabel().then {

        $0.text =
        """
        Find the exact difference
        between two dates.
        """

        $0.font =
            AppFont.bodyMedium()

        $0.textColor =
            AppColor.Text.secondary

        $0.numberOfLines = 0
    }

    // MARK: - Fields

    let startDateField =
        AppDateFieldView()

    let endDateField =
        AppDateFieldView()

    let swapButton = UIButton(type: .system).then {

        $0.setImage(
            UIImage(
                systemName:
                    "arrow.up.arrow.down.circle.fill"
            )?.applyingSymbolConfiguration(
                UIImage.SymbolConfiguration(
                    pointSize: 36,
                    weight: .regular
                )
            ),
            for: .normal
        )

        $0.tintColor =
            AppColor.Accent.primary
    }

    // MARK: - Result

    let resultCardView =
        DateDifferenceResultCardView()

    // MARK: - Container

    private let scrollView =
        UIScrollView()

    private let contentContainer =
        UIView()

    private let stackView =
        UIStackView().then {

            $0.axis = .vertical

            $0.spacing = 20
        }

    // MARK: - Setup

    override func setupView() {

        backgroundColor =
            AppColor.Background.primary

        addSubview(scrollView)

        scrollView.addSubview(
            contentContainer
        )

        contentContainer.addSubview(
            stackView
        )

        stackView.addArrangedSubview(
            titleLabel
        )

        stackView.addArrangedSubview(
            subtitleLabel
        )

        stackView.addArrangedSubview(
            startDateField
        )

        stackView.addArrangedSubview(
            swapButton
        )

        stackView.addArrangedSubview(
            endDateField
        )

        stackView.addArrangedSubview(
            resultCardView
        )
    }

    override func setupConstraints() {

        scrollView.snp.makeConstraints {

            $0.edges.equalTo(
                safeAreaLayoutGuide
            )
        }

        contentContainer.snp.makeConstraints {

            $0.edges.equalToSuperview()

            $0.width.equalToSuperview()
        }

        stackView.snp.makeConstraints {

            $0.edges.equalToSuperview()
                .inset(16)
        }

        startDateField.snp.makeConstraints {

            $0.height.equalTo(90)
        }

        endDateField.snp.makeConstraints {

            $0.height.equalTo(90)
        }

        swapButton.snp.makeConstraints {

            $0.height.equalTo(48)
        }

        resultCardView.snp.makeConstraints {

            $0.height.equalTo(360)
        }
    }
}
