//
//  ExpressionEvaluator.swift
//  ConvertTimerPro
//
//  Created by Mac Mini on 28/5/26.
//

import Foundation

final class ExpressionEvaluator {

    // MARK: - Dependencies

    private let humanizedFormatter =
        HumanizedDateFormatter()

    private let calendar =
        Calendar.current
    
    // MARK: - Public

    func evaluate(
        tokens: [TokenizedExpression]
    ) -> ExpressionResult? {

        guard
            let firstToken = tokens.first
        else {
            return nil
        }

        guard case let .time(baseDate) =
            firstToken.token
        else {
            return nil
        }

        var resultDate =
            baseDate

        var index = 1

        while index < tokens.count {

            guard index + 1 < tokens.count
            else {
                return nil
            }

            let operatorToken =
                tokens[index].token

            let valueToken =
                tokens[index + 1].token

            guard
                case let .duration(components) =
                    valueToken
            else {
                return nil
            }

            let adjustedComponents =
                adjustedComponents(
                    components,
                    using: operatorToken
                )

            guard
                let updatedDate =
                    calendar.date(
                        byAdding:
                            adjustedComponents,
                        to: resultDate
                    )
            else {
                return nil
            }

            resultDate =
                updatedDate

            index += 2
        }

        return ExpressionResult(

            date: resultDate,

            formattedTime:
                formatTime(
                    resultDate
                ),

            formattedDate:
                humanizedFormatter
                .string(
                    from: resultDate
                )
        )
    }
}

// MARK: - Private

private extension ExpressionEvaluator {

    func formatTime(
        _ date: Date
    ) -> String {

        let formatter =
            DateFormatter()

        formatter.dateFormat =
            "h:mm a"

        return formatter.string(
            from: date
        )
    }
    
    private func adjustedComponents(
        _ components: DateComponents,
        using operatorToken: ExpressionToken
    ) -> DateComponents {

        guard case .minus = operatorToken
        else {
            return components
        }

        var adjusted =
            DateComponents()

        adjusted.year =
            negate(components.year)

        adjusted.month =
            negate(components.month)

        adjusted.weekOfYear =
            negate(components.weekOfYear)

        adjusted.day =
            negate(components.day)

        adjusted.hour =
            negate(components.hour)

        adjusted.minute =
            negate(components.minute)

        return adjusted
    }

    private func negate(
        _ value: Int?
    ) -> Int? {

        guard let value else {
            return nil
        }

        return -value
    }
}
