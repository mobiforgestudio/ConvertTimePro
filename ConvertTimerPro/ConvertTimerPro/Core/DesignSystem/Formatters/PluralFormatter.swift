//
//  PluralFormatter.swift
//  ConvertTimerPro
//
//  Created by Mac Mini on 1/6/26.
//

import Foundation

enum PluralFormatter {

    static func format(
        _ value: Int,
        singular: String,
        plural: String
    ) -> String {

        value == 1
        ? "\(value) \(singular)"
        : "\(value) \(plural)"
    }
}
