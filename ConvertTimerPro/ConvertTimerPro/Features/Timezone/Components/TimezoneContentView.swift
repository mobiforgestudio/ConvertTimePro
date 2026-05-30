//
//  TimezoneContentView.swift
//  ConvertTimerPro
//
//  Created by Mac Mini on 30/5/26.
//

import UIKit
import SnapKit
import Then

final class TimezoneContentView:
    BaseView {

    let titleLabel = UILabel().then {

        $0.text =
            "Timezone Converter"

        $0.font =
            AppFont.largeTitle()

        $0.textColor =
            AppColor.Text.primary
    }

    let subtitleLabel = UILabel().then {

        $0.text =
            "Convert time between regions"

        $0.font =
            AppFont.bodyMedium()

        $0.textColor =
            AppColor.Text.secondary
    }

    let swapButton = UIButton(type: .system).then {

        $0.setImage(
            UIImage(
                systemName: "arrow.up.arrow.down.circle.fill"
            ),
            for: .normal
        )

        $0.tintColor =
            AppColor.Accent.primary
    }
    
    let fromField =
        AppSelectionFieldView()

    let toField =
        AppSelectionFieldView()

    let dateField =
        AppDateFieldView()

    let resultCardView =
        TimezoneResultCardView()

    private let scrollView =
        UIScrollView()

    private let contentView =
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
            contentView
        )

        contentView.addSubview(
            stackView
        )

        stackView.addArrangedSubview(
            titleLabel
        )

        stackView.addArrangedSubview(
            subtitleLabel
        )

        stackView.addArrangedSubview(
            fromField
        )

        stackView.addArrangedSubview(
            swapButton
        )
        
        stackView.addArrangedSubview(
            toField
        )

        stackView.addArrangedSubview(
            dateField
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

        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }

        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
                .inset(16)
        }

        fromField.snp.makeConstraints {
            $0.height.equalTo(90)
        }

        swapButton.snp.makeConstraints {
            $0.height.equalTo(44)
        }
        
        toField.snp.makeConstraints {
            $0.height.equalTo(90)
        }

        dateField.snp.makeConstraints {
            $0.height.equalTo(90)
        }

        resultCardView.snp.makeConstraints {
            $0.height.equalTo(220)
        }
    }
}
