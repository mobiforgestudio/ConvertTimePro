//
//  FavoriteRecord.swift
//  ConvertTimerPro
//
//  Created by Mac Mini on 30/5/26.
//

import Foundation
import SwiftData

@Model
final class FavoriteRecord {

    var utilityId: String

    var createdAt: Date

    init(
        utilityId: String,
        createdAt: Date = .now
    ) {

        self.utilityId =
            utilityId

        self.createdAt =
            createdAt
    }
}
