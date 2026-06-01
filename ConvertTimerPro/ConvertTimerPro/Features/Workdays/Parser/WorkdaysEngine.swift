//
//  WorkdaysEngine.swift
//  ConvertTimerPro
//
//  Created by Mac Mini on 30/5/26.
//

//
//  WorkdaysEngine.swift
//  ConvertTimerPro
//

import Foundation

final class WorkdaysEngine {

    func calculate(
        from startDate: Date,
        workdays: Int
    ) -> WorkdaysResult {

        let calendar =
            Calendar.current

        var currentDate =
            calendar.startOfDay(
                for: startDate
            )

        var remaining =
            max(
                0,
                workdays
            )

        while remaining > 0 {

            currentDate =
                calendar.date(
                    byAdding: .day,
                    value: 1,
                    to: currentDate
                ) ?? currentDate

            let weekday =
                calendar.component(
                    .weekday,
                    from: currentDate
                )

            let isWeekend =
                weekday == 1 ||
                weekday == 7

            if !isWeekend {

                remaining -= 1
            }
        }

        return WorkdaysResult(
            targetDate: currentDate,
            workdays: workdays
        )
    }
}
