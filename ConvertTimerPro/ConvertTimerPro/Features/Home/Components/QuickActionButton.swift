//
//  QuickActionButton.swift
//  ConvertTimerPro
//
//  Created by Mac Mini on 30/5/26.
//

import UIKit
import SnapKit
import Then

final class QuickActionButton: UIControl {

    private let iconView =
        UIImageView().then {

            $0.tintColor =
                AppColor.Accent.primary

            $0.contentMode =
                .scaleAspectFit
        }

    private let titleLabel =
        UILabel().then {

            $0.font =
                AppFont.body()

            $0.textColor =
                AppColor.Text.primary
        }

    init(
        icon: String,
        title: String
    ) {

        super.init(frame: .zero)

        backgroundColor =
            AppColor.Surface.card

        layer.cornerRadius = 18

        iconView.image =
            UIImage(
                systemName: icon
            )

        titleLabel.text =
            title

        addSubview(iconView)
        addSubview(titleLabel)

        iconView.snp.makeConstraints {

            $0.leading.equalToSuperview()
                .offset(16)

            $0.centerY.equalToSuperview()

            $0.size.equalTo(18)
        }

        titleLabel.snp.makeConstraints {

            $0.leading.equalTo(
                iconView.snp.trailing
            ).offset(10)

            $0.centerY.equalToSuperview()

            $0.trailing.lessThanOrEqualToSuperview()
                .offset(-16)
        }

        snp.makeConstraints {

            $0.height.equalTo(56)
        }
    }

    required init?(coder: NSCoder) {

        fatalError()
    }
}
