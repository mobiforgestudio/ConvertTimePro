//
//  BreakdownView.swift
//  ConvertTimerPro
//
//  Created by Mac Mini on 27/5/26.
//

import UIKit
import SnapKit
import Then

final class BreakdownView: BaseView {

    // MARK: - Views

    private let cardView = GlassCardView()

    private let stackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = AppSpacing.lg
    }

    // MARK: - Setup

    override func setupView() {

        addSubview(cardView)

        cardView.contentView.addSubview(
            stackView
        )
    }

    override func setupConstraints() {

        cardView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    override func setupStyle() {

        backgroundColor = .clear
    }
}

// MARK: - Public

extension BreakdownView {

    func configure(
        items: [BreakdownItem]
    ) {

        clearRows()

        items.forEach {

            let rowView = BreakdownRowView(
                item: $0
            )

            stackView.addArrangedSubview(
                rowView
            )
        }
    }
}

// MARK: - Private

private extension BreakdownView {

    func clearRows() {

        stackView.arrangedSubviews.forEach {

            stackView.removeArrangedSubview($0)

            $0.removeFromSuperview()
        }
    }
}
