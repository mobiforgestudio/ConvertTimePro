//
//  ToastView.swift
//  ConvertTimerPro
//
//  Created by Mac Mini on 29/5/26.
//

import UIKit
import SnapKit
import Then

final class ToastView: BaseView {

    private let containerView = UIView().then {
        $0.backgroundColor = UIColor.white.withAlphaComponent(0.12)
        $0.layer.cornerRadius = 18
        $0.layer.cornerCurve = .continuous
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.white.withAlphaComponent(0.08).cgColor
    }

    private let iconImageView = UIImageView().then {
        $0.image = UIImage(systemName: "checkmark.circle.fill")
        $0.tintColor = AppColor.Semantic.success
        $0.contentMode = .scaleAspectFit
    }

    private let messageLabel = UILabel().then {
        $0.font = AppFont.captionMedium()
        $0.textColor = AppColor.Text.primary
        $0.numberOfLines = 1
    }

    override func setupView() {
        backgroundColor = .clear

        addSubview(containerView)

        containerView.addSubview(iconImageView)
        containerView.addSubview(messageLabel)
    }

    override func setupConstraints() {
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(44)
        }

        iconImageView.snp.makeConstraints {
            $0.left.equalToSuperview().offset(14)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(18)
        }

        messageLabel.snp.makeConstraints {
            $0.left.equalTo(iconImageView.snp.right).offset(8)
            $0.right.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
        }
    }

    func configure(message: String) {
        messageLabel.text = message
    }
}
