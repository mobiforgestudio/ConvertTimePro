//
//  DateDifferenceEngine.swift
//  ConvertTimerPro
//
//  Created by Mac Mini on 30/5/26.
//

import Foundation

final class DateDifferenceEngine {

    func calculate(
        startDate: Date,
        endDate: Date
    ) -> DateDifferenceResult {

        let calendar =
            Calendar.current

        let components =
            calendar.dateComponents(
                [
                    .year,
                    .month,
                    .day
                ],
                from: startDate,
                to: endDate
            )

        let totalDays =
            abs(
                calendar.dateComponents(
                    [.day],
                    from: startDate,
                    to: endDate
                ).day ?? 0
            )

        return DateDifferenceResult(
            years:
                abs(components.year ?? 0),

            months:
                abs(components.month ?? 0),

            days:
                abs(components.day ?? 0),

            totalDays:
                totalDays,

            totalWeeks:
                totalDays / 7,

            totalHours:
                totalDays * 24,

            totalMinutes:
                totalDays * 24 * 60
        )
    }
}
