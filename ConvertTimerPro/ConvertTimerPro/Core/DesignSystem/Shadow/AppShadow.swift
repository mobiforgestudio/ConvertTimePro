//
//  AppShadow.swift
//  ConvertTimerPro
//
//  Created by Mac Mini on 27/5/26.
//

import UIKit

struct Shadow {

    let color: UIColor
    let offset: CGSize
    let radius: CGFloat
    let opacity: Float
}

enum AppShadow {

    static let cardShadow = Shadow(
        color: UIColor.black.withAlphaComponent(0.35),
        offset: CGSize(width: 0, height: 12),
        radius: 24,
        opacity: 1
    )

    static let floatingShadow = Shadow(
        color: UIColor.black.withAlphaComponent(0.45),
        offset: CGSize(width: 0, height: 20),
        radius: 40,
        opacity: 1
    )

    static let glow = Shadow(
        color: AppColor.Accent.glow,
        offset: .zero,
        radius: 20,
        opacity: 1
    )
}
