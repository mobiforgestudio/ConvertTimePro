//
//  AgeContentView.swift
//  ConvertTimerPro
//
//  Created by Mac Mini on 30/5/26.
//

import UIKit
import SnapKit
import Then

final class AgeContentView:
    BaseView {

    let titleLabel = UILabel().then {

        $0.text =
            "Age Calculator"

        $0.font =
            AppFont.largeTitle()

        $0.textColor =
            AppColor.Text.primary
    }

    let subtitleLabel = UILabel().then {
        $0.text =
            """
            Find your exact age in years,
            months, days and more.
            """
        
        $0.font =
            AppFont.bodyMedium()

        $0.textColor =
            AppColor.Text.secondary

        $0.numberOfLines = 0
    }

    let birthDateField =
        AppDateFieldView()

    let resultCardView =
        AgeResultCardView()

    private let scrollView =
        UIScrollView()

    private let contentContainer =
        UIView()

    private let stackView =
        UIStackView().then {

            $0.axis = .vertical

            $0.spacing = 20
        }

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
            birthDateField
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

        birthDateField.snp.makeConstraints {

            $0.height.equalTo(90)
        }

        resultCardView.snp.makeConstraints {

            $0.height.equalTo(400)
        }
    }
}
