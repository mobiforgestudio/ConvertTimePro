//
//  RecordsSectionView.swift
//  ConvertTimerPro
//
//  Created by Mac Mini on 28/5/26.
//

import UIKit
import SnapKit
import Then

final class RecordsSectionView:
    BaseView {

    // MARK: - Public

    var onSelectHistory:
        ((HistoryRecord) -> Void)?

    var onDeleteHistory:
        ((HistoryRecord) -> Void)?
    
    var onTogglePinHistory:
        ((HistoryRecord) -> Void)?
    
    // MARK: - Views

    private let titleLabel =
        UILabel().then {
            $0.font =
                AppFont.title3()

            $0.textColor =
                AppColor.Text.primary
        }

    private let stackView =
        UIStackView().then {

            $0.axis = .vertical
            $0.spacing = AppSpacing.md
        }

    // MARK: - Setup

    override func setupView() {

        addSubview(titleLabel)

        addSubview(stackView)
    }

    override func setupConstraints() {

        titleLabel.snp.makeConstraints {

            $0.top.left.right
                .equalToSuperview()
        }

        stackView.snp.makeConstraints {

            $0.top.equalTo(
                titleLabel.snp.bottom
            ).offset(AppSpacing.md)

            $0.left.right.bottom
                .equalToSuperview()
        }
    }
}

// MARK: - Public

extension RecordsSectionView {

    func configure(
        title: String,
        records: [HistoryRecord]
    ) {

        titleLabel.text = title
        
        stackView
            .arrangedSubviews
            .forEach {

                $0.removeFromSuperview()
            }

        records.forEach { record in

            let itemView =
                HistoryItemView()

            itemView.configure(
                expression:
                    record.expression,
                result:
                    record.result,
                createdAt:
                    record.createdAt,
                isPinned:
                    record.isPinned
            )

            itemView.onTap = {
                [weak self] in

                self?.onSelectHistory?(
                    record
                )
            }

            itemView.onDelete = {
                [weak self] in

                self?.onDeleteHistory?(
                    record
                )
            }
            
            itemView.onTogglePin = {
                [weak self] in

                self?.onTogglePinHistory?(
                    record
                )
            }
            
            stackView.addArrangedSubview(
                itemView
            )
        }

        isHidden =
            records.isEmpty
    }
}
