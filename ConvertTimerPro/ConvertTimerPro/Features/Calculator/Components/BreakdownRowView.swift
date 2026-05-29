//
//  BreakdownRowView.swift
//  ConvertTimerPro
//
//  Created by Mac Mini on 27/5/26.
//

import UIKit
import SnapKit
import Then

final class BreakdownRowView: BaseView {

    // MARK: - Properties

    private let item: BreakdownItem

    // MARK: - Views

    private let titleLabel = UILabel().then {
        $0.font = AppFont.body()
        $0.textColor = AppColor.Text.secondary
        $0.numberOfLines = 1
    }

    private let valueLabel = UILabel().then {
        $0.font = AppFont.bodySemibold()
        $0.textColor = AppColor.Text.primary
        $0.textAlignment = .right
        $0.numberOfLines = 1
    }

    // MARK: - Init

    init(
        item: BreakdownItem
    ) {
        self.item = item

        super.init(frame: .zero)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup

    override func setupView() {

        addSubview(titleLabel)
        addSubview(valueLabel)
    }

    override func setupConstraints() {

        snp.makeConstraints {
            $0.height.greaterThanOrEqualTo(32)
        }

        titleLabel.snp.makeConstraints {
            $0.left.top.bottom.equalToSuperview()

            $0.right.lessThanOrEqualTo(
                valueLabel.snp.left
            ).offset(-AppSpacing.md)
        }

        valueLabel.snp.makeConstraints {
            $0.right.top.bottom.equalToSuperview()
        }
    }

    override func setupData() {

        titleLabel.text = item.title

        valueLabel.text = item.value
    }

    override func setupStyle() {

        backgroundColor = .clear
    }
}
