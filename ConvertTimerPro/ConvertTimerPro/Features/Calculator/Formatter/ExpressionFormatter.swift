//
//  ExpressionFormatter.swift
//  ConvertTimerPro
//
//  Created by Mac Mini on 28/5/26.
//

import Foundation

final class ExpressionFormatter {

    // MARK: - Public

    func format(
        _ input: String
    ) -> String {

        guard !input.isEmpty else {
            return input
        }

        var result = input

        result = normalizeOperators(
            result
        )

        result = collapseSpaces(
            result
        )

        return result
            .trimmingCharacters(
                in: .whitespacesAndNewlines
            )
    }
}

// MARK: - Private

private extension ExpressionFormatter {

    func normalizeOperators(
        _ input: String
    ) -> String {

        input
            .replacingOccurrences(
                of: "+",
                with: " + "
            )
            .replacingOccurrences(
                of: "-",
                with: " - "
            )
    }

    func collapseSpaces(
        _ input: String
    ) -> String {

        input.replacingOccurrences(
            of: #"\s+"#,
            with: " ",
            options: .regularExpression
        )
    }
}
