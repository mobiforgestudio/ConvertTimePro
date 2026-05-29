//
//  ChipView.swift
//  ConvertTimerPro
//
//  Created by Mac Mini on 27/5/26.
//

import UIKit
import SnapKit
import Then

final class ChipView: UIControl {

    // MARK: - Public

    var isChipSelected: Bool = false {
        didSet {
            updateAppearance()
        }
    }

    // MARK: - Views

    private let containerView = UIView().then {
        $0.isUserInteractionEnabled = false
    }

    private let blurView = UIVisualEffectView(
        effect: UIBlurEffect(
            style: .systemUltraThinMaterialDark
        )
    )

    private let backgroundOverlayView = UIView().then {
        $0.isUserInteractionEnabled = false
    }

    private let stackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = AppSpacing.xs
        $0.alignment = .center
    }

    private let iconImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.tintColor = AppColor.Text.secondary
    }

    private let titleLabel = UILabel().then {
        $0.font = AppFont.captionMedium()
        $0.textAlignment = .center
        $0.textColor = AppColor.Text.secondary
    }

    // MARK: - Properties

    private let title: String

    private let icon: UIImage?

    // MARK: - Init

    init(
        title: String,
        icon: UIImage? = nil
    ) {

        self.title = title
        self.icon = icon

        super.init(frame: .zero)

        setupView()
        setupConstraints()
        setupStyle()
        setupData()
        bind()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Intrinsic Size

    override var intrinsicContentSize: CGSize {

        let labelSize =
            titleLabel.intrinsicContentSize

        let iconWidth: CGFloat =
            icon == nil ? 0 : 18

        let width =
            labelSize.width
            + iconWidth
            + AppSpacing.lg * 2
            + (iconWidth > 0 ? AppSpacing.xs : 0)

        return CGSize(
            width: width,
            height: 36
        )
    }
}

// MARK: - Setup

private extension ChipView {

    func setupView() {

        addSubview(containerView)

        containerView.addSubview(blurView)

        containerView.addSubview(
            backgroundOverlayView
        )

        containerView.addSubview(stackView)

        if icon != nil {
            stackView.addArrangedSubview(
                iconImageView
            )
        }

        stackView.addArrangedSubview(
            titleLabel
        )
    }

    func setupConstraints() {

        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        blurView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        backgroundOverlayView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
                .inset(
                    UIEdgeInsets(
                        top: AppSpacing.sm,
                        left: AppSpacing.lg,
                        bottom: AppSpacing.sm,
                        right: AppSpacing.lg
                    )
                )
        }

        iconImageView.snp.makeConstraints {
            $0.size.equalTo(18)
        }
    }

    func setupStyle() {

        backgroundColor = .clear

        layer.cornerRadius = 18
        layer.cornerCurve = .continuous

        clipsToBounds = true

        containerView.layer.cornerRadius = 18
        containerView.layer.cornerCurve = .continuous
        containerView.clipsToBounds = true

        backgroundOverlayView.backgroundColor =
            UIColor.white.withAlphaComponent(0.03)

        setContentHuggingPriority(
            .required,
            for: .horizontal
        )

        setContentCompressionResistancePriority(
            .required,
            for: .horizontal
        )

        updateAppearance()
    }

    func setupData() {

        titleLabel.text = title

        iconImageView.image = icon
    }

    func bind() {

        addTarget(
            self,
            action: #selector(didTouchDown),
            for: .touchDown
        )

        addTarget(
            self,
            action: #selector(didTouchUp),
            for: [
                .touchUpInside,
                .touchDragExit,
                .touchCancel
            ]
        )
    }
}

// MARK: - Actions

private extension ChipView {

    @objc
    func didTouchDown() {

        UIView.animate(
            withDuration: AppAnimation.fast
        ) {

            self.transform =
                CGAffineTransform(
                    scaleX: 0.96,
                    y: 0.96
                )
        }
    }

    @objc
    func didTouchUp() {

        UIView.animate(
            withDuration: AppAnimation.fast,
            delay: 0,
            usingSpringWithDamping: 0.7,
            initialSpringVelocity: 0.5
        ) {

            self.transform = .identity
        }
    }

    func updateAppearance() {

        if isChipSelected {

            backgroundOverlayView.backgroundColor =
                AppColor.Accent.primary
                    .withAlphaComponent(0.16)

            titleLabel.textColor =
                AppColor.Accent.primary

            iconImageView.tintColor =
                AppColor.Accent.primary

        } else {

            backgroundOverlayView.backgroundColor =
                UIColor.white.withAlphaComponent(0.03)

            titleLabel.textColor =
                AppColor.Text.secondary

            iconImageView.tintColor =
                AppColor.Text.secondary
        }
    }
}
