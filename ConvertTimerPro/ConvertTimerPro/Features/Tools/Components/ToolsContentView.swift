//
//  ToolsContentView.swift
//  ConvertTimerPro
//
//  Created by Mac Mini on 30/5/26.
//

import UIKit
import SnapKit
import Then

final class ToolsContentView:
    BaseView {

    let timeSection =
        UtilitySectionView()

    let dateSection =
        UtilitySectionView()

    let calculationSection =
        UtilitySectionView()

    private let scrollView =
        UIScrollView()

    private let contentView =
        UIView()

    private let stackView =
        UIStackView().then {

            $0.axis = .vertical

            $0.spacing = 24
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

        let title =
            UILabel()

        title.text =
            "Tools"

        title.font =
            AppFont.largeTitle()

        title.textColor =
            AppColor.Text.primary

        let subtitle =
            UILabel()

        subtitle.text =
            "All utilities in one place"

        subtitle.font =
            AppFont.bodyMedium()

        subtitle.textColor =
            AppColor.Text.secondary

        stackView.addArrangedSubview(
            title
        )

        stackView.addArrangedSubview(
            subtitle
        )

        stackView.addArrangedSubview(
            timeSection
        )

        stackView.addArrangedSubview(
            dateSection
        )

        stackView.addArrangedSubview(
            calculationSection
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
    }
}
