//
//  UIView+Shadow.swift
//  ConvertTimerPro
//
//  Created by Mac Mini on 27/5/26.
//

import UIKit

extension UIView {

    func applyShadow(_ shadow: Shadow) {
        layer.shadowColor = shadow.color.cgColor
        layer.shadowOffset = shadow.offset
        layer.shadowRadius = shadow.radius
        layer.shadowOpacity = shadow.opacity
    }
}
