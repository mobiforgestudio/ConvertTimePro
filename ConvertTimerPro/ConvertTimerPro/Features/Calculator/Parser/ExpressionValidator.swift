//
//  ExpressionValidator.swift
//  ConvertTimerPro
//
//  Created by Mac Mini on 28/5/26.
//

import Foundation

final class ExpressionValidator {

    // MARK: - Public

    func validate(
        input: String
    ) -> [ExpressionValidationError] {

        let trimmed =
            input.trimmingCharacters(
                in: .whitespacesAndNewlines
            )

        guard !trimmed.isEmpty else {
            return []
        }

        let components =
            trimmed
            .split(separator: " ")
            .map(String.init)

        // Incomplete != Invalid
        // User may still be typing.

        guard components.count >= 3 else {
            return []
        }

        var errors: [
            ExpressionValidationError
        ] = []

        validateOperator(
            components[1],
            input: input,
            errors: &errors
        )

        validateDuration(
            components[2],
            input: input,
            errors: &errors
        )

        return errors
    }
}

// MARK: - Private

private extension ExpressionValidator {

    func validateOperator(
        _ token: String,
        input: String,
        errors: inout [
            ExpressionValidationError
        ]
    ) {

        let validOperators = [
            "+",
            "-"
        ]

        guard !validOperators.contains(
            token
        ) else {
            return
        }

        errors.append(
            ExpressionValidationError(
                range: range(
                    of: token,
                    in: input
                ),
                message: "Invalid operator"
            )
        )
    }

    func validateDuration(
        _ token: String,
        input: String,
        errors: inout [
            ExpressionValidationError
        ]
    ) {

        // User may still be typing:
        // 10
        // 120
        // etc.

        if isNumericOnly(token) {
            return
        }

        guard !isValidDuration(token) else {
            return
        }

        errors.append(
            ExpressionValidationError(
                range: range(
                    of: token,
                    in: input
                ),
                message: "Invalid duration"
            )
        )
    }

    func isValidDuration(
        _ token: String
    ) -> Bool {

        let regex =
            try? NSRegularExpression(
                pattern:
                    #"^(\d+)(h|m|d)(\d+(h|m|d))*$"#,
                options: [
                    .caseInsensitive
                ]
            )

        let range = NSRange(
            location: 0,
            length:
                (token as NSString).length
        )

        return regex?.firstMatch(
            in: token,
            options: [],
            range: range
        ) != nil
    }

    func isNumericOnly(
        _ token: String
    ) -> Bool {

        let regex =
            try? NSRegularExpression(
                pattern: #"^\d+$"#,
                options: []
            )

        let range = NSRange(
            location: 0,
            length:
                (token as NSString).length
        )

        return regex?.firstMatch(
            in: token,
            options: [],
            range: range
        ) != nil
    }

    func range(
        of token: String,
        in input: String
    ) -> NSRange {

        (input as NSString)
            .range(of: token)
    }
}
