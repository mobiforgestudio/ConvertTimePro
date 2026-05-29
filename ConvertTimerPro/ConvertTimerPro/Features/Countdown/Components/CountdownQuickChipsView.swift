//
//  CountdownQuickChipsView.swift
//  ConvertTimerPro
//
//  Created by Mac Mini on 29/5/26.
//

import UIKit
import SnapKit
import Then

final class CountdownQuickChipsView: BaseView {

    var onChipSelected: ((String) -> Void)?

    private let scrollView = UIScrollView().then {
        $0.showsHorizontalScrollIndicator = false
    }

    private let stackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 8
        $0.alignment = .fill
    }

    private let chips = [
        "Today",
        "Tomorrow",
        "Next Week",
        "Next Month"
    ]

    override func setupView() {

        addSubview(scrollView)

        scrollView.addSubview(stackView)

        chips.forEach {

            let button =
                makeChip(
                    title: $0
                )

            stackView.addArrangedSubview(
                button
            )
        }
    }

    override func setupConstraints() {

        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalToSuperview()
        }
    }
}

private extension CountdownQuickChipsView {

    func makeChip(
        title: String
    ) -> UIButton {

        let button =
            UIButton(type: .system)

        button.setTitle(
            title,
            for: .normal
        )

        button.setTitleColor(
            AppColor.Text.primary,
            for: .normal
        )

        button.titleLabel?.font =
            AppFont.caption()

        button.backgroundColor =
            AppColor.Surface.elevated

        button.layer.cornerRadius = 18

        button.layer.borderWidth = 1

        button.layer.borderColor =
            AppColor.Border.subtle.cgColor

        button.contentEdgeInsets =
            UIEdgeInsets(
                top: 8,
                left: 14,
                bottom: 8,
                right: 14
            )

        button.addAction(
            UIAction {
                [weak self] _ in

                self?.onChipSelected?(
                    title
                )
            },
            for: .touchUpInside
        )

        return button
    }
}
