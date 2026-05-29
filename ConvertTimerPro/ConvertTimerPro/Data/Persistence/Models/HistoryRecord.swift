//
//  HistoryRecord.swift
//  ConvertTimerPro
//
//  Created by Mac Mini on 28/5/26.
//

import Foundation
import SwiftData

@Model
final class HistoryRecord {

    var expression: String

    var result: String

    var createdAt: Date

    var isPinned: Bool
    
    init(
        expression: String,
        result: String,
        createdAt: Date = .now,
        isPinned: Bool = false
    ) {

        self.expression =
            expression

        self.result =
            result

        self.createdAt =
            createdAt

        self.isPinned =
            isPinned
    }
}
