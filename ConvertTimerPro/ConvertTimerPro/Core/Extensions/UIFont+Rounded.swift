//
//  UIFont+Rounded.swift
//  ConvertTimerPro
//
//  Created by Mac Mini on 27/5/26.
//

import UIKit

extension UIFont {

    func rounded() -> UIFont {
        guard let descriptor = fontDescriptor.withDesign(.rounded) else {
            return self
        }

        return UIFont(
            descriptor: descriptor,
            size: pointSize
        )
    }
}
