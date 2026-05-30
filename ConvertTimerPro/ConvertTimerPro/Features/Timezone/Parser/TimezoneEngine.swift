//
//  TimezoneEngine.swift
//  ConvertTimerPro
//
//  Created by Mac Mini on 30/5/26.
//

import Foundation

final class TimezoneEngine {

    func convert(
        date: Date,
        from: TimeZone,
        to: TimeZone
    ) -> TimezoneResult {

        let fromOffset =
            from.secondsFromGMT(
                for: date
            )

        let toOffset =
            to.secondsFromGMT(
                for: date
            )

        let difference =
            toOffset - fromOffset

        let convertedDate =
            date.addingTimeInterval(
                TimeInterval(
                    difference
                )
            )

        return TimezoneResult(
            sourceDate: date,
            convertedDate: convertedDate,
            fromTimeZone: from,
            toTimeZone: to,
            offsetHours: difference / 3600
        )
    }
}
