//
//  ExpressionTokenizer.swift
//  ConvertTimerPro
//
//  Created by Mac Mini on 28/5/26.
//

import Foundation

final class ExpressionTokenizer {

    // MARK: - Public

    func tokenize(
        input: String
    ) -> [TokenizedExpression] {
        
        let pattern =
        #"(\d{1,2}:\d{2}\s*(am|pm)?)|(\d{1,2}\s*(am|pm))|((\d+\s*(y|mo|w|d|h|m))+)|(\+)|(\-)|(now|today|tomorrow)"#

        Logger.log("========== TOKENIZE ==========")
        Logger.log("INPUT: \(input)")
        
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
                options: [],
                range: NSRange(
                    location: 0,
                    length: nsString.length
                )
            )

        
         matches.forEach {

             let value =
                 nsString.substring(
                     with: $0.range
                 )

             Logger.log("MATCH: \(value)")
         }
        
        return matches.compactMap {

            match in

            let rawValue =
                nsString.substring(
                    with: match.range
                )

            let normalizedValue =
                rawValue
                .lowercased()
                .replacingOccurrences(
                    of: " ",
                    with: ""
                )

            guard
                let token =
                    token(
                        from: normalizedValue
                    )
            else {
                return nil
            }

            return TokenizedExpression(
                token: token,
                range: match.range
            )
        }
    }

    func tokenAtCursor(
        input: String,
        cursor: Int
    ) -> TokenizedExpression? {

        tokenize(input: input)
            .first {

                let start =
                    $0.range.location

                let end =
                    $0.range.location
                    + $0.range.length

                return cursor >= start
                    && cursor <= end
            }
    }
}

// MARK: - Private

private extension ExpressionTokenizer {

    func token(
        from value: String
    ) -> ExpressionToken? {

        if value == "+" {
            return .plus
        }

        if value == "-" {
            return .minus
        }

        if isKeyword(value) {

            return .time(
                keywordDate(value)
            )
        }

        if let date =
            parseTime(value) {

            return .time(date)
        }

        if let duration =
            parseDuration(value) {

            return .duration(duration)
        }

        return .unknown(value)
    }

    // MARK: - Keyword

    func isKeyword(
        _ value: String
    ) -> Bool {

        [
            "now",
            "today",
            "tomorrow"
        ].contains(value)
    }

    func keywordDate(
        _ value: String
    ) -> Date {

        let calendar =
            Calendar.current

        switch value {

        case "tomorrow":

            return calendar.date(
                byAdding: .day,
                value: 1,
                to: Date()
            ) ?? Date()

        case "today",
             "now":

            fallthrough

        default:

            return Date()
        }
    }

    // MARK: - Time

    func parseTime(
        _ value: String
    ) -> Date? {

        let formatters = [

            "H:mm",
            "h:mma",
            "ha"
        ]

        for format in formatters {

            let formatter =
                DateFormatter()

            formatter.locale =
                Locale(
                    identifier: "en_US_POSIX"
                )

            formatter.dateFormat =
                format

            if let date =
                formatter.date(
                    from: value
                ) {

                let calendar =
                    Calendar.current

                let timeComponents =
                    calendar.dateComponents(
                        [
                            .hour,
                            .minute
                        ],
                        from: date
                    )

                return calendar.date(
                    bySettingHour:
                        timeComponents.hour ?? 0,
                    minute:
                        timeComponents.minute ?? 0,
                    second: 0,
                    of: Date()
                )
            }
        }

        return nil
    }

    // MARK: - Duration

    func parseDuration(
        _ value: String
    ) -> DateComponents? {

        let pattern =
            #"(\d+)(y|mo|w|d|h|m)"#

        guard
            let regex =
                try? NSRegularExpression(
                    pattern: pattern,
                    options: [.caseInsensitive]
                )
        else {
            return nil
        }

        let nsString =
            value as NSString

        let matches =
            regex.matches(
                in: value,
                options: [],
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

        matches.forEach { match in

            guard
                match.numberOfRanges >= 3
            else {
                return
            }

            let number =
                nsString.substring(
                    with: match.range(at: 1)
                )

            let unit =
                nsString.substring(
                    with: match.range(at: 2)
                )

            guard
                let value =
                    Int(number)
            else {
                return
            }

            switch unit {

            case "y":

                components.year =
                    (components.year ?? 0)
                    + value

            case "mo":

                components.month =
                    (components.month ?? 0)
                    + value

            case "w":

                components.weekOfYear =
                    (components.weekOfYear ?? 0)
                    + value

            case "d":

                components.day =
                    (components.day ?? 0)
                    + value

            case "h":

                components.hour =
                    (components.hour ?? 0)
                    + value

            case "m":

                components.minute =
                    (components.minute ?? 0)
                    + value

            default:

                break
            }
        }

        return components
    }
}
