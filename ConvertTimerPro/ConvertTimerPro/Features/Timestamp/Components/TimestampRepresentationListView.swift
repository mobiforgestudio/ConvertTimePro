//
//  TimestampRepresentationListView.swift
//  ConvertTimerPro
//
//  Created by Mac Mini on 28/5/26.
//

import UIKit
import SnapKit
import Then

final class TimestampRepresentationListView: BaseView {

    // MARK: - Callback

    var onCopyRepresentation:
        ((TimestampRepresentation) -> Void)?

    // MARK: - Views

    private let titleLabel = UILabel().then {
        $0.text = "Representations"

        $0.font =
            AppFont.bodyMedium()

        $0.textColor =
            AppColor.Text.primary
    }

    private let stackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 14
    }
}

// MARK: - Public

extension TimestampRepresentationListView {

    func configure(
        representations:
            [TimestampRepresentation]
    ) {

        stackView.arrangedSubviews
            .forEach {

                $0.removeFromSuperview()
            }

        representations.forEach {
            representation in

            let rowView =
                TimestampRepresentationRowView()

            rowView.configure(
                with: representation
            )

            rowView.onCopy = {
                [weak self] in

                UIPasteboard.general.string =
                    representation.copyValue

                self?.onCopyRepresentation?(
                    representation
                )
            }

            stackView.addArrangedSubview(
                rowView
            )
        }
    }
}

// MARK: - Setup

extension TimestampRepresentationListView {

    override func setupView() {

        backgroundColor = .clear

        addSubview(titleLabel)

        addSubview(stackView)

        titleLabel.snp.makeConstraints {
            $0.top.leading.trailing
                .equalToSuperview()
        }

        stackView.snp.makeConstraints {
            $0.top.equalTo(
                titleLabel.snp.bottom
            ).offset(18)

            $0.leading.trailing.bottom
                .equalToSuperview()
        }
    }
}
