//
//  CountdownContentView.swift
//  ConvertTimerPro
//
//  Created by Mac Mini on 29/5/26.
//

import UIKit
import SnapKit
import Then

final class CountdownContentView: BaseView {

    // MARK: - Public

    let titleLabel = UILabel().then {
        $0.text = "Countdown"
        $0.font = AppFont.largeTitle()
        $0.textColor = AppColor.Text.primary
    }

    let eventTextField = UITextField().then {
        
        $0.attributedPlaceholder =
            NSAttributedString(
                string: "Event Name",
                attributes: [
                    .foregroundColor:
                        AppColor.Text.secondary
                ]
            )
        
        $0.textColor =
            AppColor.Text.primary

        $0.font =
            AppFont.bodyMedium()

        $0.backgroundColor =
            AppColor.Surface.input

        $0.layer.cornerRadius = 20

        $0.layer.borderWidth = 1

        $0.layer.borderColor =
            AppColor.Border.subtle.cgColor

        let spacer =
            UIView(
                frame: CGRect(
                    x: 0,
                    y: 0,
                    width: 16,
                    height: 1
                )
            )

        $0.leftView = spacer

        $0.leftViewMode = .always

        $0.clearButtonMode = .whileEditing
        
        $0.returnKeyType = .done
        
        $0.isHidden = true
    }

    let dateInputView =
        CountdownDateInputView()

    let quickChipsView =
        CountdownQuickChipsView()

    let resultCardView =
        CountdownResultCardView()

    // MARK: - Private

    private let scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
        $0.alwaysBounceVertical = true
    }

    private let contentView = UIView()

    private let stackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 20
    }

    // MARK: - Setup

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
            eventTextField
        )

        stackView.addArrangedSubview(
            dateInputView
        )

        stackView.addArrangedSubview(
            quickChipsView
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
                .inset(
                    UIEdgeInsets(
                        top: 16,
                        left: 16,
                        bottom: 32,
                        right: 16
                    )
                )
        }

        eventTextField.snp.makeConstraints {
            $0.height.equalTo(56)
        }

        quickChipsView.snp.makeConstraints {
            $0.height.equalTo(40)
        }

        resultCardView.snp.makeConstraints {
            $0.height.equalTo(340)
        }
    }
}
