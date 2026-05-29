//
//  ExpressionSyntaxHighlighter.swift
//  ConvertTimerPro
//
//  Created by Mac Mini on 28/5/26.
//

import UIKit

final class ExpressionSyntaxHighlighter: SyntaxHighlighting {

    // MARK: - Public

    func highlight(
        text: String,
        validationErrors: [
            ExpressionValidationError
        ] = []
    ) -> NSAttributedString {

        let attributedString =
            NSMutableAttributedString(
                string: text,
                attributes: baseAttributes
            )

        applyPatterns(
            to: attributedString,
            text: text
        )

        applyValidationErrors(
            validationErrors,
            to: attributedString
        )

        return attributedString
    }
}

// MARK: - Private

private extension ExpressionSyntaxHighlighter {

    var baseAttributes: [
        NSAttributedString.Key: Any
    ] {

        [
            .font:
                AppFont.expressionInput(),

            .foregroundColor:
                AppColor.Text.primary
        ]
    }

    var patterns: [SyntaxPattern] {

        [

            // Time

            SyntaxPattern(
                regex:
                    #"\b\d{1,2}:\d{2}\b"#,
                color:
                    AppColor.Syntax.time
            ),

            // Duration

            SyntaxPattern(
                regex:
                    #"\b\d+\s*(h|m|d)\b"#,
                color:
                    AppColor.Syntax.duration
            ),

            // Operators

            SyntaxPattern(
                regex:
                    #"(\+|\-|->|\bfrom\b|\bto\b)"#,
                color:
                    AppColor.Syntax.operation
            ),

            // Keywords

            SyntaxPattern(
                regex:
                    #"\b(now|today|tomorrow|yesterday|next)\b"#,
                color:
                    AppColor.Syntax.keyword
            )
        ]
    }

    func applyPatterns(
        to attributedString:
            NSMutableAttributedString,
        text: String
    ) {

        patterns.forEach { pattern in

            guard
                let regex =
                    try? NSRegularExpression(
                        pattern: pattern.regex,
                        options: [
                            .caseInsensitive
                        ]
                    )
            else {
                return
            }

            let range = NSRange(
                location: 0,
                length:
                    (text as NSString).length
            )

            let matches =
                regex.matches(
                    in: text,
                    options: [],
                    range: range
                )

            matches.forEach { match in

                attributedString
                    .addAttributes(
                        [
                            .foregroundColor:
                                pattern.color,

                            .font:
                                AppFont
                                .expressionInput()
                        ],
                        range: match.range
                    )
            }
        }
    }

    func applyValidationErrors(
        _ errors: [ExpressionValidationError],
        to attributedString: NSMutableAttributedString
    ) {

        let fullLength = attributedString.length

        errors.forEach { error in

            guard error.range.location >= 0,
                  error.range.location < fullLength
            else {
                return
            }

            let safeLength = min(
                error.range.length,
                fullLength - error.range.location
            )

            guard safeLength > 0 else {
                return
            }

            let safeRange = NSRange(
                location: error.range.location,
                length: safeLength
            )

            attributedString.addAttributes(
                [
                    .foregroundColor: UIColor.systemRed,
                    .underlineStyle: NSUnderlineStyle.single.rawValue,
                    .underlineColor: UIColor.systemRed.withAlphaComponent(0.7)
                ],
                range: safeRange
            )
        }
    }
}

// MARK: - SyntaxPattern

private struct SyntaxPattern {

    let regex: String

    let color: UIColor
}
