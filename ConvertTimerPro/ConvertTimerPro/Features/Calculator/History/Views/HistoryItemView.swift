//
//  HistoryItemView.swift
//  ConvertTimerPro
//
//  Created by Mac Mini on 28/5/26.
//

import UIKit
import SnapKit
import Then

final class HistoryItemView: BaseView {

    // MARK: - Public

    var onTap: (() -> Void)?
    var onDelete: (() -> Void)?
    var onTogglePin: (() -> Void)?
    
    // MARK: - Views

    private let containerView =
        UIView().then {

            $0.backgroundColor =
                UIColor.white
                .withAlphaComponent(0.06)

            $0.layer.cornerRadius = 22

            $0.layer.borderWidth = 1

            $0.layer.borderColor =
                UIColor.white
                .withAlphaComponent(0.05)
                .cgColor
        }

    private let expressionLabel =
        UILabel().then {

            $0.font =
                AppFont.bodyMedium()

            $0.textColor =
                AppColor.Text.primary

            $0.numberOfLines = 1

            $0.lineBreakMode =
                .byTruncatingTail
        }

    private let resultLabel =
        UILabel().then {

            $0.font =
                AppFont.bodyMedium()

            $0.textColor =
                AppColor.Text.primary

            $0.textAlignment = .right
        }

    private let dateLabel =
        UILabel().then {

            $0.font =
                AppFont.captionMedium()

            $0.textColor =
                AppColor.Text.secondary
        }

    private var isPinned =
        false
    
    // MARK: - Setup

    override func setupView() {

        addSubview(containerView)

        containerView.addSubview(
            expressionLabel
        )

        containerView.addSubview(
            resultLabel
        )

        containerView.addSubview(
            dateLabel
        )
    }

    override func setupConstraints() {

        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(82)
        }

        expressionLabel.snp.makeConstraints {

            $0.top.equalToSuperview()
                .offset(16)

            $0.left.equalToSuperview()
                .offset(18)

            $0.right.lessThanOrEqualTo(
                resultLabel.snp.left
            ).offset(-12)
        }

        resultLabel.snp.makeConstraints {

            $0.centerY.equalTo(
                expressionLabel
            )

            $0.right.equalToSuperview()
                .inset(18)
        }

        dateLabel.snp.makeConstraints {

            $0.left.equalTo(
                expressionLabel
            )

            $0.bottom.equalToSuperview()
                .inset(16)
        }
    }

    override func bind() {

        let tap =
            UITapGestureRecognizer(
                target: self,
                action: #selector(
                    didTapView
                )
            )

        addGestureRecognizer(tap)
        
        let interaction =
            UIContextMenuInteraction(
                delegate: self
            )

        addInteraction(interaction)
    }
}

// MARK: - Public

extension HistoryItemView {

    func configure(
        expression: String,
        result: String,
        createdAt: Date,
        isPinned: Bool
    ) {

        self.isPinned = isPinned
        
        expressionLabel.text =
            expression

        resultLabel.text =
            result

        dateLabel.text =
            relativeDateString(
                from: createdAt
            )
    }
}

// MARK: - Actions

private extension HistoryItemView {

    @objc
    func didTapView() {

        animateTap()

        onTap?()
    }

    func animateTap() {

        UIView.animate(
            withDuration: 0.12,
            animations: {

                self.transform =
                    CGAffineTransform(
                        scaleX: 0.98,
                        y: 0.98
                    )
            },
            completion: { _ in

                UIView.animate(
                    withDuration: 0.2
                ) {

                    self.transform =
                        .identity
                }
            }
        )
    }

    func relativeDateString(
        from date: Date
    ) -> String {

        let formatter =
            RelativeDateTimeFormatter()

        formatter.unitsStyle =
            .short

        return formatter.localizedString(
            for: date,
            relativeTo: Date()
        )
    }
}

extension HistoryItemView:
    UIContextMenuInteractionDelegate {

    func contextMenuInteraction(
        _ interaction:
            UIContextMenuInteraction,
        configurationForMenuAtLocation
        location: CGPoint
    ) -> UIContextMenuConfiguration? {

        UIContextMenuConfiguration(
            identifier: nil,
            previewProvider: nil
        ) { _ in

            UIMenu(
                children: [

                    UIAction(
                        title: "Delete",
                        image: UIImage(
                            systemName:
                                "trash"
                        ),
                        attributes: .destructive
                    ) { _ in

                        self.onDelete?()
                    },
                    
                    UIAction(
                        title:
                            self.isPinned
                            ? "Unpin"
                            : "Pin",

                        image: UIImage(
                            systemName:
                                self.isPinned
                                ? "pin.slash"
                                : "pin"
                        )
                    ) { _ in

                        self.onTogglePin?()
                    }
                ]
            )
        }
    }
}
