//
//  TimestampFormatter.swift
//  ConvertTimerPro
//
//  Created by Mac Mini on 28/5/26.
//

import Foundation

final class TimestampFormatter {

    func makeResult(
        from date: Date
    ) -> TimestampResult {

        TimestampResult(
            date: date,

            titleDate:
                formatDate(date),

            timeText:
                formatTime(date),

            timezoneText:
                formatTimezone(),

            representations:
                makeRepresentations(date)
        )
    }
}

private extension TimestampFormatter {

    func formatDate(
        _ date: Date
    ) -> String {

        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMM d, yyyy"

        return formatter.string(from: date)
    }

    func formatTime(
        _ date: Date
    ) -> String {

        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm:ss a"

        return formatter.string(from: date)
    }

    func formatTimezone() -> String {

        let offset =
            TimeZone.current.secondsFromGMT()

        let hours =
            offset / 3600

        return String(
            format: "GMT%+d",
            hours
        )
    }

    func makeRepresentations(
        _ date: Date
    ) -> [TimestampRepresentation] {

        let seconds = Int(date.timeIntervalSince1970)
        let milliseconds = Int(date.timeIntervalSince1970 * 1000)

        let isoFormatter = ISO8601DateFormatter()

        return [
            TimestampRepresentation(
                title: "Unix seconds",
                value: "\(seconds)",
                copyValue: "\(seconds)"
            ),
            TimestampRepresentation(
                title: "Unix milliseconds",
                value: "\(milliseconds)",
                copyValue: "\(milliseconds)"
            ),
            TimestampRepresentation(
                title: "ISO 8601",
                value: isoFormatter.string(from: date),
                copyValue: isoFormatter.string(from: date)
            )
        ]
    }
}
