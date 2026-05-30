//
//  UtilityCategory.swift
//  ConvertTimerPro
//
//  Created by Mac Mini on 30/5/26.
//

import Foundation

enum UtilityCategory:
    String,
    CaseIterable {

    case time

    case date

    case calculation

    var title: String {

        switch self {

        case .time:
            return "Time"

        case .date:
            return "Date"

        case .calculation:
            return "Calculation"
        }
    }
}
