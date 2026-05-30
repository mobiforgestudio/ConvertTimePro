//
//  PersistenceController.swift
//  ConvertTimerPro
//
//  Created by Mac Mini on 28/5/26.
//

import SwiftData

final class PersistenceController {

    // MARK: - Shared

    static let shared =
        PersistenceController()

    // MARK: - Properties

    let container: ModelContainer

    // MARK: - Init

    private init() {

        do {

            container =
                try ModelContainer(
                    for:
                        HistoryRecord.self,
                        FavoriteRecord.self
                )

        } catch {

            fatalError(
                "Failed to create ModelContainer: \(error)"
            )
        }
    }
}
