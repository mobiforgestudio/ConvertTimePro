//
//  TimezoneViewModel.swift
//  ConvertTimerPro
//
//  Created by Mac Mini on 30/5/26.
//

import Foundation

final class TimezoneViewModel {

    private let engine =
        TimezoneEngine()

    var selectedDate =
        Date()

    var fromTimeZone =
        TimezoneItem.gmt7

    var toTimeZone =
        TimezoneItem.utc

    func convert()
    -> TimezoneResult {

        engine.convert(
            date: selectedDate,
            from: fromTimeZone.timeZone,
            to: toTimeZone.timeZone
        )
    }
}
