//
//  AutocompleteEngine.swift
//  ConvertTimerPro
//
//  Created by Mac Mini on 28/5/26.
//

import Foundation

final class AutocompleteEngine {

    // MARK: - Public

    func suggestions(
        for input: String
    ) -> [AutocompleteSuggestion] {

        let normalized =
            input.lowercased()

        if normalized.isEmpty {
            return []
        }

        if normalized.hasSuffix("+") ||
            normalized.hasSuffix("-") {

            return durationSuggestions
        }

        if isNumericInput(normalized) {

            return [

                .init(
                    title: "\(normalized)h",
                    insertText: "\(normalized)h"
                ),

                .init(
                    title: "\(normalized)m",
                    insertText: "\(normalized)m"
                ),

                .init(
                    title: "\(normalized)d",
                    insertText: "\(normalized)d"
                )
            ]
        }

        if "tomorrow".hasPrefix(normalized) {

            return [
                .init(
                    title: "tomorrow",
                    insertText: "tomorrow"
                )
            ]
        }

        if "today".hasPrefix(normalized) {

            return [
                .init(
                    title: "today",
                    insertText: "today"
                )
            ]
        }

        if "now".hasPrefix(normalized) {

            return [
                .init(
                    title: "now",
                    insertText: "now"
                )
            ]
        }

        return []
    }
}

// MARK: - Private

private extension AutocompleteEngine {

    var durationSuggestions: [
        AutocompleteSuggestion
    ] {

        [

            .init(
                title: "1h",
                insertText: "1h"
            ),

            .init(
                title: "30m",
                insertText: "30m"
            ),

            .init(
                title: "1d",
                insertText: "1d"
            )
        ]
    }

    func isNumericInput(
        _ input: String
    ) -> Bool {

        let regex =
            try? NSRegularExpression(
                pattern: #"^\d+$"#
            )

        let range = NSRange(
            location: 0,
            length:
                (input as NSString).length
        )

        return regex?.firstMatch(
            in: input,
            options: [],
            range: range
        ) != nil
    }
}
