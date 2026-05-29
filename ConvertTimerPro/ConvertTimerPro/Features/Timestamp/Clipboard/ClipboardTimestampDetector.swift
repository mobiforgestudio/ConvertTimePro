//
//  ClipboardTimestampDetector.swift
//  ConvertTimerPro
//
//  Created by Mac Mini on 29/5/26.
//

import UIKit

final class ClipboardTimestampDetector {

    func detect() -> ClipboardTimestamp? {

        guard
            let text =
                UIPasteboard
                .general
                .string?
                .trimmingCharacters(
                    in: .whitespacesAndNewlines
                )
        else {
            return nil
        }

        let digits =
            CharacterSet.decimalDigits

        guard
            CharacterSet(
                charactersIn: text
            )
            .isSubset(
                of: digits
            )
        else {
            return nil
        }

        guard
            text.count == 10 ||
            text.count == 13
        else {
            return nil
        }

        return ClipboardTimestamp(
            value: text
        )
    }
}
