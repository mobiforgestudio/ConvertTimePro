//
//  AppCardView.swift
//  ConvertTimerPro
//
//  Created by Mac Mini on 30/5/26.
//

import UIKit

class AppCardView: BaseView {

    override func setupView() {

        backgroundColor =
            AppColor.Surface.card

        layer.cornerRadius = 24

        layer.borderWidth = 1

        layer.borderColor =
            AppColor.Border.subtle.cgColor
    }
}
