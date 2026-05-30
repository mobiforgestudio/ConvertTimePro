//
//  DateDifferenceViewModel.swift
//  ConvertTimerPro
//
//  Created by Mac Mini on 30/5/26.
//

import Foundation

final class DateDifferenceViewModel {

    private let engine =
        DateDifferenceEngine()

    var startDate =
        Calendar.current.date(
            byAdding: .month,
            value: -1,
            to: Date()
        ) ?? Date()

    var endDate =
        Date()

    func calculate()
    -> DateDifferenceResult {

        engine.calculate(
            startDate: startDate,
            endDate: endDate
        )
    }
}
