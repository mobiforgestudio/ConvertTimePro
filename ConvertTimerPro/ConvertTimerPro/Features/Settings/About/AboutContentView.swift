//
//  AboutContentView.swift
//  ConvertTimerPro
//
//  Created by Mac Mini on 30/5/26.
//

import UIKit
import SnapKit
import Then

final class AboutContentView:
    BaseView {

    let versionLabel =
        UILabel().then {

            $0.font =
                AppFont.bodyMedium()

            $0.textColor =
                AppColor.Text.secondary

            $0.textAlignment =
                .center
        }

    private let scrollView =
        UIScrollView()

    private let contentContainer =
        UIView()

    private let stackView =
        UIStackView().then {

            $0.axis = .vertical

            $0.spacing = 20
        }

    private let iconLabel =
        UILabel().then {

            $0.text = "⏱"

            $0.font =
                .systemFont(
                    ofSize: 56
                )

            $0.textAlignment =
                .center
        }

    private let appNameLabel =
        UILabel().then {

            $0.text =
                "ConvertTimer Pro"

            $0.font =
                AppFont.largeTitle()

            $0.textColor =
                AppColor.Text.primary

            $0.textAlignment =
                .center
        }

    private let studioCard =
        AppCardView()

    private let appStoreCard =
        AppCardView()

    private let websiteCard =
        AppCardView()

    private let utilitiesCard =
        AppCardView()

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

        setupHeader()
        setupStudioCard()
        setupAppStoreCard()
        setupWebsiteCard()
        setupUtilitiesCard()
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
    }
}

// MARK: - Header

private extension AboutContentView {

    func setupHeader() {

        stackView.addArrangedSubview(
            iconLabel
        )

        stackView.addArrangedSubview(
            appNameLabel
        )

        stackView.addArrangedSubview(
            versionLabel
        )
    }
}

// MARK: - Studio

private extension AboutContentView {

    func setupStudioCard() {

        let title =
            makeCaptionLabel(
                "Built by"
            )

        let name =
            makePrimaryLabel(
                "Mobiforge Studio"
            )

        let description =
            UILabel().then {

                $0.text =
                """
                We build simple, beautiful
                and productive mobile apps.
                """

                $0.numberOfLines = 0

                $0.font =
                    AppFont.bodyMedium()

                $0.textColor =
                    AppColor.Text.secondary
            }

        studioCard.addSubview(
            title
        )

        studioCard.addSubview(
            name
        )

        studioCard.addSubview(
            description
        )

        title.snp.makeConstraints {

            $0.top.leading.trailing
                .equalToSuperview()
                .inset(20)
        }

        name.snp.makeConstraints {

            $0.top.equalTo(
                title.snp.bottom
            ).offset(8)

            $0.leading.trailing
                .equalTo(title)
        }

        description.snp.makeConstraints {

            $0.top.equalTo(
                name.snp.bottom
            ).offset(8)

            $0.leading.trailing
                .equalTo(title)

            $0.bottom.equalToSuperview()
                .offset(-20)
        }

        stackView.addArrangedSubview(
            studioCard
        )
    }
}

// MARK: - App Store

private extension AboutContentView {

    func setupAppStoreCard() {

        let title =
            makeCaptionLabel(
                "App Store ID"
            )

        let value =
            makePrimaryLabel(
                "6774896408"
            )

        appStoreCard.addSubview(
            title
        )

        appStoreCard.addSubview(
            value
        )

        title.snp.makeConstraints {

            $0.top.leading.trailing
                .equalToSuperview()
                .inset(20)
        }

        value.snp.makeConstraints {

            $0.top.equalTo(
                title.snp.bottom
            ).offset(8)

            $0.leading.trailing
                .equalTo(title)

            $0.bottom.equalToSuperview()
                .offset(-20)
        }

        stackView.addArrangedSubview(
            appStoreCard
        )
    }
}

// MARK: - Website

private extension AboutContentView {

    func setupWebsiteCard() {

        let title =
            makeCaptionLabel(
                "Website"
            )

        let value =
            UILabel().then {

                $0.text =
                    "https://mobiforge-site.pages.dev"

                $0.font =
                    AppFont.bodyMedium()

                $0.textColor =
                    AppColor.Accent.primary
            }

        websiteCard.addSubview(
            title
        )

        websiteCard.addSubview(
            value
        )

        title.snp.makeConstraints {

            $0.top.leading.trailing
                .equalToSuperview()
                .inset(20)
        }

        value.snp.makeConstraints {

            $0.top.equalTo(
                title.snp.bottom
            ).offset(8)

            $0.leading.trailing
                .equalTo(title)

            $0.bottom.equalToSuperview()
                .offset(-20)
        }

        stackView.addArrangedSubview(
            websiteCard
        )
    }
}

// MARK: - Utilities

private extension AboutContentView {

    func setupUtilitiesCard() {

        let title =
            makeCaptionLabel(
                "Utilities"
            )

        let value =
            makePrimaryLabel(
                "\(UtilityItem.allCases.count) Tools Available"
            )

        utilitiesCard.addSubview(
            title
        )

        utilitiesCard.addSubview(
            value
        )

        title.snp.makeConstraints {

            $0.top.leading.trailing
                .equalToSuperview()
                .inset(20)
        }

        value.snp.makeConstraints {

            $0.top.equalTo(
                title.snp.bottom
            ).offset(8)

            $0.leading.trailing
                .equalTo(title)

            $0.bottom.equalToSuperview()
                .offset(-20)
        }

        stackView.addArrangedSubview(
            utilitiesCard
        )
    }
}

// MARK: - Helpers

private extension AboutContentView {

    func makeCaptionLabel(
        _ text: String
    ) -> UILabel {

        UILabel().then {

            $0.text = text

            $0.font =
                AppFont.caption()

            $0.textColor =
                AppColor.Text.secondary
        }
    }

    func makePrimaryLabel(
        _ text: String
    ) -> UILabel {

        UILabel().then {

            $0.text = text

            $0.font =
                AppFont.bodyMedium()

            $0.textColor =
                AppColor.Text.primary
        }
    }
}
