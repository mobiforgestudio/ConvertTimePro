//
//  TimestampContentView.swift
//  ConvertTimerPro
//
//  Created by Mac Mini on 28/5/26.
//

import UIKit
import SnapKit
import Then

final class TimestampContentView: BaseView {

    // MARK: - Views

    let scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
        $0.alwaysBounceVertical = true
    }

    private let containerView = UIView()

    private let stackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 24
    }

    let titleLabel = UILabel().then {
        $0.text = "Unix Time"

        $0.font =
            AppFont.largeTitle()

        $0.textColor =
            AppColor.Text.primary
    }

    let expressionInputView =
        ExpressionInputView(
            syntaxHighlighter:
                TimestampSyntaxHighlighter()
        )

    let resultCardView =
        TimestampResultCardView()

    let representationsView =
        TimestampRepresentationListView()
    
    let quickChipsView =
        TimestampQuickChipsView()
    
    let clipboardBannerView =
        TimestampClipboardBannerView()
}

// MARK: - Setup

extension TimestampContentView {

    override func setupView() {

        clipboardBannerView.isHidden = true
        
        backgroundColor =
            AppColor.Background.primary

        addSubview(scrollView)

        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        scrollView.addSubview(containerView)

        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }

        containerView.addSubview(stackView)

        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(
                UIEdgeInsets(
                    top: 20,
                    left: 20,
                    bottom: 32,
                    right: 20
                )
            )
        }

        setupStack()
    }
}

// MARK: - Private

private extension TimestampContentView {

    func setupStack() {

        stackView.addArrangedSubview(
            titleLabel
        )

        stackView.addArrangedSubview(
            clipboardBannerView
        )
        
        stackView.addArrangedSubview(
            expressionInputView
        )

        stackView.addArrangedSubview(
            quickChipsView
        )
        
        stackView.addArrangedSubview(
            resultCardView
        )
        
        stackView.addArrangedSubview(
            representationsView
        )

        expressionInputView.snp.makeConstraints {
            $0.height.greaterThanOrEqualTo(72)
        }

        resultCardView.snp.makeConstraints {
            $0.height.greaterThanOrEqualTo(170)
        }
        
        clipboardBannerView.snp.makeConstraints {
            $0.height.equalTo(72)
        }
    }
}
