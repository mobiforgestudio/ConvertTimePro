//
//  GlassCardView.swift
//  ConvertTimerPro
//
//  Created by Mac Mini on 27/5/26.
//

import UIKit
import SnapKit
import Then

final class GlassCardView: UIView {

    // MARK: - Properties

    private let contentInsets: UIEdgeInsets

    // MARK: - Containers

    private let shadowContainerView = UIView()

    private let cardContainerView = UIView().then {
        $0.backgroundColor = .clear
        $0.clipsToBounds = true
    }

    // MARK: - Layers

    private let blurView = UIVisualEffectView(
        effect: UIBlurEffect(
            style: .systemUltraThinMaterialDark
        )
    )

    private let overlayView = UIView().then {
        $0.backgroundColor = AppColor.Surface.glassOverlay
        $0.isUserInteractionEnabled = false
    }

    private let borderView = UIView().then {
        $0.backgroundColor = .clear
        $0.layer.borderWidth = 1
        $0.layer.borderColor = AppColor.Border.subtle.cgColor
        $0.isUserInteractionEnabled = false
    }

    // MARK: - Public

    let contentView = UIView()

    // MARK: - Init

    init(
        contentInsets: UIEdgeInsets = UIEdgeInsets(
            top: AppSpacing.xl,
            left: AppSpacing.xl,
            bottom: AppSpacing.xl,
            right: AppSpacing.xl
        )
    ) {

        self.contentInsets = contentInsets

        super.init(frame: .zero)

        setupView()
        setupLayout()
        setupStyle()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup

private extension GlassCardView {

    func setupView() {

        addSubview(shadowContainerView)

        shadowContainerView.addSubview(
            cardContainerView
        )

        cardContainerView.addSubview(blurView)
        cardContainerView.addSubview(overlayView)
        cardContainerView.addSubview(contentView)
        cardContainerView.addSubview(borderView)
    }

    func setupLayout() {

        shadowContainerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        cardContainerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        blurView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        overlayView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
                .inset(contentInsets)
        }

        borderView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    func setupStyle() {

        backgroundColor = .clear

        shadowContainerView.applyShadow(
            AppShadow.cardShadow
        )

        cardContainerView.layer.cornerRadius =
            AppRadius.xl

        cardContainerView.layer.cornerCurve =
            .continuous

        borderView.layer.cornerRadius =
            AppRadius.xl

        borderView.layer.cornerCurve =
            .continuous
    }
}
