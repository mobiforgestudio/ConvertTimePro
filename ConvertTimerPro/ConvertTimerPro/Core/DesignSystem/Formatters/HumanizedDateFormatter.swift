//
//  HumanizedDateFormatter.swift
//  ConvertTimerPro
//
//  Created by Mac Mini on 28/5/26.
//

import Foundation

final class HumanizedDateFormatter {

    // MARK: - Dependencies

    private let calendar =
        Calendar.current

    // MARK: - Public

    func string(
        from date: Date
    ) -> String {

        if calendar.isDateInToday(date) {
            return "Today"
        }

        if calendar.isDateInTomorrow(date) {
            return "Tomorrow"
        }

        if calendar.isDateInYesterday(date) {
            return "Yesterday"
        }

        let startOfToday =
            calendar.startOfDay(
                for: Date()
            )

        let startOfTarget =
            calendar.startOfDay(
                for: date
            )

        let dayDifference =
            calendar.dateComponents(
                [.day],
                from: startOfToday,
                to: startOfTarget
            ).day ?? 0

        // MARK: - Within 7 days

        if abs(dayDifference) <= 7 {

            let weekdayFormatter =
                DateFormatter()

            weekdayFormatter.locale =
                Locale.current

            weekdayFormatter.dateFormat =
                "EEEE"

            return weekdayFormatter
                .string(
                    from: date
                )
        }

        // MARK: - Far dates

        let formatter =
            DateFormatter()

        formatter.locale =
            Locale.current

        formatter.dateFormat =
            "MMM d, yyyy"

        return formatter.string(
            from: date
        )
    }
}
