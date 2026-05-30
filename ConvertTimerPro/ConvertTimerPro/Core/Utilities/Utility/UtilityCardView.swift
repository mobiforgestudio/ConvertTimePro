//
//  UtilityCardView.swift
//  ConvertTimerPro
//
//  Created by Mac Mini on 30/5/26.
//

import UIKit
import SnapKit
import Then

final class UtilityCardView:
    AppCardView {

    var onTap: (() -> Void)?

    var onFavoriteTap: (() -> Void)?
    
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
                AppFont.bodyMedium()

            $0.textColor =
                AppColor.Text.primary
        }

    private let subtitleLabel =
        UILabel().then {

            $0.font =
                AppFont.caption()

            $0.textColor =
                AppColor.Text.secondary

            $0.numberOfLines = 2
        }

    private let favoriteButton =
        UIButton(
            type: .system
        ).then {

            $0.tintColor =
                AppColor.Accent.primary
        }
    
    override func setupView() {

        super.setupView()

        addSubview(iconView)
        addSubview(titleLabel)
        addSubview(subtitleLabel)
        addSubview(favoriteButton)

        favoriteButton.addTarget(
            self,
            action: #selector(
                didTapFavorite
            ),
            for: .touchUpInside
        )
        
        favoriteButton.setPreferredSymbolConfiguration(
            UIImage.SymbolConfiguration(
                pointSize: 18,
                weight: .medium
            ),
            forImageIn: .normal
        )
        
        favoriteButton.isUserInteractionEnabled =
            true
        
        let tap =
            UITapGestureRecognizer(
                target: self,
                action: #selector(
                    didTapCard
                )
            )

        addGestureRecognizer(tap)
    }

    override func setupConstraints() {

        iconView.snp.makeConstraints {

            $0.leading.equalToSuperview()
                .offset(16)

            $0.centerY.equalToSuperview()

            $0.size.equalTo(20)
        }

        titleLabel.snp.makeConstraints {

            $0.top.equalToSuperview()
                .offset(16)

            $0.leading.equalTo(
                iconView.snp.trailing
            ).offset(12)

            $0.trailing.lessThanOrEqualTo(
                favoriteButton.snp.leading
            ).offset(-12)
        }

        favoriteButton.snp.makeConstraints {

            $0.trailing.equalToSuperview()
                .offset(-16)

            $0.centerY.equalToSuperview()

            $0.size.equalTo(18)
        }
        
        subtitleLabel.snp.makeConstraints {

            $0.top.equalTo(
                titleLabel.snp.bottom
            ).offset(4)

            $0.leading.equalTo(
                titleLabel
            )

            $0.trailing.equalTo(
                titleLabel
            )

            $0.bottom.lessThanOrEqualToSuperview()
                .offset(-16)
        }
    }

    func configure(
        item: UtilityItem,
        isFavorite: Bool,
        showsFavoriteButton: Bool = true
    ) {

        titleLabel.text =
            item.title

        subtitleLabel.text =
            item.subtitle

        iconView.image =
            UIImage(
                systemName:
                    item.icon
            )

        favoriteButton.isHidden =
            !showsFavoriteButton

        favoriteButton.setImage(
            UIImage(
                systemName:
                    isFavorite
                    ? "star.fill"
                    : "star"
            ),
            for: .normal
        )
    }

    @objc
    private func didTapCard() {

        onTap?()
    }
    
    @objc
    private func didTapFavorite() {

        onFavoriteTap?()
    }
}
