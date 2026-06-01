//
//  WorkdaysQuickChipsView.swift
//  ConvertTimerPro
//
//  Created by Mac Mini on 30/5/26.
//

import UIKit
import SnapKit
import Then

final class WorkdaysQuickChipsView:
    BaseView {

    var onChipSelected:
        ((Int) -> Void)?

    private let chips =
        [5, 10, 30, 60]

    private var buttons:
        [UIButton] = []

    private var selectedValue:
        Int = 30

    override func setupView() {

        let stack =
            UIStackView()

        stack.axis = .horizontal

        stack.spacing = 12

        stack.distribution =
            .fillEqually

        addSubview(stack)

        stack.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        chips.forEach { value in

            let button =
                UIButton(type: .system)

            button.setTitle(
                "+\(value)",
                for: .normal
            )

            button.tag = value

            button.layer.cornerRadius = 16

            button.layer.borderWidth = 1

            button.addTarget(
                self,
                action: #selector(
                    didTapChip
                ),
                for: .touchUpInside
            )

            buttons.append(
                button
            )

            stack.addArrangedSubview(
                button
            )
        }

        updateSelection()
    }

    func select(
        _ value: Int
    ) {

        selectedValue =
            value

        updateSelection()
    }

    private func updateSelection() {

        buttons.forEach { button in

            let selected =
                button.tag ==
                selectedValue

            button.backgroundColor =
                selected
                ? AppColor.Accent.primary
                    .withAlphaComponent(0.15)
                : AppColor.Surface.input

            button.layer.borderColor =
                selected
                ? AppColor.Accent.primary.cgColor
                : AppColor.Border.subtle.cgColor

            button.setTitleColor(
                selected
                ? AppColor.Accent.primary
                : AppColor.Text.primary,
                for: .normal
            )
        }
    }

    @objc
    private func didTapChip(
        _ sender: UIButton
    ) {

        selectedValue =
            sender.tag

        updateSelection()

        onChipSelected?(
            sender.tag
        )
    }
    
    func clearSelection() {

        selectedValue = -1

        updateSelection()
    }
}
