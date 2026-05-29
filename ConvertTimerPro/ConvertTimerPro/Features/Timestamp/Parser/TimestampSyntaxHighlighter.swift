//
//  TimestampSyntaxHighlighter.swift
//  ConvertTimerPro
//
//  Created by Mac Mini on 29/5/26.
//

import UIKit

final class TimestampSyntaxHighlighter: SyntaxHighlighting {
    func highlight(
        text: String,
        validationErrors: [ExpressionValidationError]
    ) -> NSAttributedString {

        let attributed =
            NSMutableAttributedString(
                string: text,
                attributes: [
                    .font:
                        AppFont.expressionInput(),

                    .foregroundColor:
                        AppColor.Text.primary
                ]
            )

        highlightNow(
            attributed
        )

        highlightUnix(
            attributed
        )

        highlightOperators(
            attributed
        )

        highlightDurations(
            attributed
        )

        return attributed
    }
}

private extension TimestampSyntaxHighlighter {
    
    func highlightNow(
        _ attributed: NSMutableAttributedString
    ) {
        apply(
            pattern: #"\bnow\b"#,
            color: AppColor.Syntax.keyword,
            to: attributed
        )
    }
    
    func highlightUnix(
        _ attributed: NSMutableAttributedString
    ) {
        apply(
            pattern: #"\b\d{10,13}\b"#,
            color: AppColor.Syntax.time,
            to: attributed
        )
    }
    
    func highlightOperators(
        _ attributed: NSMutableAttributedString
    ) {
        apply(
            pattern: #"[\+\-]"#,
            color: AppColor.Syntax.operation,
            to: attributed
        )
    }
    
    func highlightDurations(
        _ attributed: NSMutableAttributedString
    ) {
        apply(
            pattern: #"(\d+\s*(y|mo|w|d|h|m))+"#,
            color: AppColor.Syntax.duration,
            to: attributed
        )
    }
    
    func apply(
        pattern: String,
        color: UIColor,
        to attributed: NSMutableAttributedString
    ) {
        guard let regex = try? NSRegularExpression(
            pattern: pattern,
            options: [.caseInsensitive]
        ) else {
            return
        }
        
        let range = NSRange(
            location: 0,
            length: attributed.length
        )
        
        regex.matches(
            in: attributed.string,
            range: range
        ).forEach {
            attributed.addAttribute(
                .foregroundColor,
                value: color,
                range: $0.range
            )
        }
    }
}
