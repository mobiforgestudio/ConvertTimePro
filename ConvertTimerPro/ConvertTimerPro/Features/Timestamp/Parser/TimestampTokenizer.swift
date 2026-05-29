//
//  TimestampTokenizer.swift
//  ConvertTimerPro
//
//  Created by Mac Mini on 29/5/26.
//

import Foundation

final class TimestampTokenizer {

    func tokenize(
        input: String
    ) -> [TimestampToken] {

        let pattern =
        #"(\d{10,13})|((\d+\s*(y|mo|w|d|h|m))+)|(\+)|(\-)|(now)"#

        guard
            let regex =
                try? NSRegularExpression(
                    pattern: pattern,
                    options: [.caseInsensitive]
                )
        else {
            return []
        }

        let nsString =
            input as NSString

        let matches =
            regex.matches(
                in: input,
                range: NSRange(
                    location: 0,
                    length: nsString.length
                )
            )

        return matches.compactMap {

            let value =
                nsString.substring(
                    with: $0.range
                )
                .lowercased()

            if value == "now" {
                return .now
            }

            if value == "+" {
                return .plus
            }

            if value == "-" {
                return .minus
            }

            if let duration =
                parseDuration(
                    value
                ) {

                return .duration(
                    duration
                )
            }

            if let date =
                parseUnixTimestamp(
                    value
                ) {

                return .unix(date)
            }

            return nil
        }
    }
}

// MARK: - Private

private extension TimestampTokenizer {

    func parseUnixTimestamp(
        _ value: String
    ) -> Date? {

        guard
            let timestamp =
                Double(value)
        else {
            return nil
        }

        if value.count == 13 {

            return Date(
                timeIntervalSince1970:
                    timestamp / 1000
            )
        }

        if value.count == 10 {

            return Date(
                timeIntervalSince1970:
                    timestamp
            )
        }

        return nil
    }

    func parseDuration(
        _ value: String
    ) -> DateComponents? {

        let regex =
            try? NSRegularExpression(
                pattern: #"(\d+)(y|mo|w|d|h|m)"#
            )

        guard
            let regex
        else {
            return nil
        }

        let nsString =
            value as NSString

        let matches =
            regex.matches(
                in: value,
                range: NSRange(
                    location: 0,
                    length: nsString.length
                )
            )

        guard !matches.isEmpty
        else {
            return nil
        }

        var components =
            DateComponents()

        matches.forEach {

            let amount =
                Int(
                    nsString.substring(
                        with: $0.range(at: 1)
                    )
                ) ?? 0

            let unit =
                nsString.substring(
                    with: $0.range(at: 2)
                )

            switch unit {

            case "y":
                components.year = amount

            case "mo":
                components.month = amount

            case "w":
                components.weekOfYear = amount

            case "d":
                components.day = amount

            case "h":
                components.hour = amount

            case "m":
                components.minute = amount

            default:
                break
            }
        }

        return components
    }
}
