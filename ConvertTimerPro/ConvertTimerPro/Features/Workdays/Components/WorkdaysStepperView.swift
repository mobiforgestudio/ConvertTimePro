//
//  WorkdaysStepperView.swift
//  ConvertTimerPro
//
//  Created by Mac Mini on 30/5/26.
//

import UIKit
import SnapKit
import Then

final class WorkdaysStepperView: BaseView {

    var onValueChanged: ((Int) -> Void)?

    private(set) var value = 30 {
        didSet {
            valueLabel.text =
                "\(value) Business Days"
        }
    }

    private let minusButton =
        UIButton(type: .system)

    private let plusButton =
        UIButton(type: .system)

    private let valueLabel = UILabel().then {

        $0.font = .systemFont(
            ofSize: 28,
            weight: .bold
        )

        $0.textColor =
            AppColor.Text.primary

        $0.textAlignment =
            .center
    }

    override func setupView() {

        backgroundColor =
            AppColor.Surface.input

        layer.cornerRadius = 20

        minusButton.setImage(
            UIImage(
                systemName: "minus.circle.fill"
            ),
            for: .normal
        )

        plusButton.setImage(
            UIImage(
                systemName: "plus.circle.fill"
            ),
            for: .normal
        )

        minusButton.tintColor =
            AppColor.Accent.primary

        plusButton.tintColor =
            AppColor.Accent.primary

        valueLabel.text =
            "\(value) Business Days"

        addSubview(minusButton)
        addSubview(valueLabel)
        addSubview(plusButton)

        minusButton.addTarget(
            self,
            action: #selector(
                didTapMinus
            ),
            for: .touchUpInside
        )

        plusButton.addTarget(
            self,
            action: #selector(
                didTapPlus
            ),
            for: .touchUpInside
        )
    }

    override func setupConstraints() {

        minusButton.snp.makeConstraints {
            $0.leading.equalToSuperview()
                .offset(20)

            $0.centerY.equalToSuperview()

            $0.size.equalTo(32)
        }

        plusButton.snp.makeConstraints {
            $0.trailing.equalToSuperview()
                .offset(-20)

            $0.centerY.equalToSuperview()

            $0.size.equalTo(32)
        }

        valueLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }

    func setValue(
        _ value: Int
    ) {

        self.value =
            max(
                0,
                value
            )
    }

    @objc
    private func didTapMinus() {

        value =
            max(
                0,
                value - 1
            )

        onValueChanged?(
            value
        )
    }

    @objc
    private func didTapPlus() {

        value += 1

        onValueChanged?(
            value
        )
    }
}
