//
//  TimestampExpressionEngine.swift
//  ConvertTimerPro
//
//  Created by Mac Mini on 29/5/26.
//

import Foundation

final class TimestampExpressionEngine {

    private let tokenizer =
        TimestampTokenizer()

    private let calendar =
        Calendar.current

    func evaluate(
        input: String
    ) -> Date? {

        let tokens =
            tokenizer.tokenize(
                input: input
            )

        guard
            let first =
                tokens.first
        else {
            return Date()
        }

        var resultDate: Date

        switch first {

        case .now:
            resultDate = Date()

        case let .unix(date):
            resultDate = date

        default:
            return nil
        }

        var index = 1

        while index + 1 < tokens.count {

            let operation =
                tokens[index]

            guard
                case let .duration(duration) =
                    tokens[index + 1]
            else {
                return nil
            }

            switch operation {

            case .plus:

                guard let updatedDate =
                    calendar.date(
                        byAdding: duration,
                        to: resultDate
                    )
                else {
                    return nil
                }

                resultDate =
                    updatedDate

            case .minus:

                var negative =
                    DateComponents()

                negative.year =
                    -(duration.year ?? 0)

                negative.month =
                    -(duration.month ?? 0)

                negative.weekOfYear =
                    -(duration.weekOfYear ?? 0)

                negative.day =
                    -(duration.day ?? 0)

                negative.hour =
                    -(duration.hour ?? 0)

                negative.minute =
                    -(duration.minute ?? 0)

                guard let updatedDate =
                    calendar.date(
                        byAdding: negative,
                        to: resultDate
                    )
                else {
                    return nil
                }

                resultDate =
                    updatedDate

            default:
                return nil
            }

            index += 2
        }

        return resultDate
    }
}
