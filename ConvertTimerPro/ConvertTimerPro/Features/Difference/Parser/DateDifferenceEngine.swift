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

        let calendar = Calendar.current

        let normalizedStart =
            calendar.startOfDay(
                for: startDate
            )

        let normalizedEnd =
            calendar.startOfDay(
                for: endDate
            )

        let components =
            calendar.dateComponents(
                [
                    .year,
                    .month,
                    .day
                ],
                from: normalizedStart,
                to: normalizedEnd
            )

        let totalDays =
            abs(
                calendar.dateComponents(
                    [.day],
                    from: normalizedStart,
                    to: normalizedEnd
                ).day ?? 0
            )

        return DateDifferenceResult(
            years:
                abs(
                    components.year ?? 0
                ),

            months:
                abs(
                    components.month ?? 0
                ),

            days:
                abs(
                    components.day ?? 0
                ),

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
