//
//  CountdownEngine.swift
//  ConvertTimerPro
//
//  Created by Mac Mini on 29/5/26.
//

import Foundation

final class CountdownEngine {

    func calculate(
        targetDate: Date,
        eventName: String = ""
    ) -> CountdownResult {

        let now = Date()

        let interval =
            targetDate.timeIntervalSince(
                now
            )

        let isOverdue =
            interval < 0

        let absoluteInterval =
            abs(interval)

        let totalSeconds =
            Int(absoluteInterval)

        let rawDays =
            Calendar.current.dateComponents(
                [.day],
                from: now,
                to: targetDate
            ).day ?? 0

        let days =
            abs(rawDays)

        let weeks =
            days / 7

        let hours =
            totalSeconds / 3600

        let remainingHours =
            (totalSeconds % 86400) / 3600

        let remainingMinutes =
            (totalSeconds % 3600) / 60

        let remainingSeconds =
            totalSeconds % 60

        return CountdownResult(
            days: days,
            weeks: weeks,
            hours: hours,
            targetDate: targetDate,
            eventName: eventName,
            isOverdue: isOverdue,
            remainingHours: remainingHours,
            remainingMinutes: remainingMinutes,
            remainingSeconds: remainingSeconds
        )
    }
}
