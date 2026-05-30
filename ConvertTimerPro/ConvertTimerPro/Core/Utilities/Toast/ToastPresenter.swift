//
//  ToastPresenter.swift
//  ConvertTimerPro
//
//  Created by Mac Mini on 29/5/26.
//

import UIKit
import SnapKit

final class ToastPresenter {

    static let shared = ToastPresenter()

    private var currentToast: ToastView?

    private init() {}

    func show(
        message: String,
        in view: UIView
    ) {
        currentToast?.removeFromSuperview()

        let toast = ToastView()
        toast.configure(message: message)

        view.addSubview(toast)

        toast.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(64)
            $0.width.lessThanOrEqualToSuperview().inset(32)
        }

        toast.alpha = 0
        toast.transform = CGAffineTransform(translationX: 0, y: 12)

        currentToast = toast

        UIView.animate(
            withDuration: 0.22,
            delay: 0,
            options: [.curveEaseOut]
        ) {
            toast.alpha = 1
            toast.transform = .identity
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.4) {
            UIView.animate(
                withDuration: 0.22,
                delay: 0,
                options: [.curveEaseIn]
            ) {
                toast.alpha = 0
                toast.transform = CGAffineTransform(translationX: 0, y: 12)
            } completion: { _ in
                toast.removeFromSuperview()

                if self.currentToast === toast {
                    self.currentToast = nil
                }
            }
        }
    }
}

extension ToastPresenter {

    func show(
        message: String
    ) {

        guard let window =
            UIApplication.shared
                .connectedScenes
                .compactMap({
                    $0 as? UIWindowScene
                })
                .first?
                .keyWindow
        else {
            return
        }

        show(
            message: message,
            in: window
        )
    }
}
