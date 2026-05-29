//
//  TimestampParser.swift
//  ConvertTimerPro
//
//  Created by Mac Mini on 28/5/26.
//

import Foundation

final class TimestampParser {

    private let engine =
        TimestampExpressionEngine()

    func parse(
        input: String
    ) -> Date? {

        engine.evaluate(
            input: input
        )
    }
}
