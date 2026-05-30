//
//  FavoriteStore.swift
//  ConvertTimerPro
//
//  Created by Mac Mini on 30/5/26.
//

import Foundation
import SwiftData

final class FavoriteStore {

    // MARK: - Dependencies

    private let context:
        ModelContext

    // MARK: - Init

    init(
        context: ModelContext
    ) {

        self.context =
            context
    }

    // MARK: - Public

    func fetchAll()
    -> [FavoriteRecord] {

        do {

            let descriptor =
                FetchDescriptor<
                    FavoriteRecord
                >(
                    sortBy: [
                        SortDescriptor(
                            \.createdAt,
                            order: .reverse
                        )
                    ]
                )

            return try context.fetch(
                descriptor
            )

        } catch {

            print(
                "❌ Fetch favorites failed:",
                error
            )

            return []
        }
    }

    func favoriteItems()
    -> [UtilityItem] {

        fetchAll()
            .compactMap {

                UtilityItem(
                    rawValue:
                        $0.utilityId
                )
            }
    }

    func isFavorite(
        _ item: UtilityItem
    ) -> Bool {

        fetchAll()
            .contains {

                $0.utilityId ==
                item.rawValue
            }
    }

    func add(
        _ item: UtilityItem
    ) {

        guard !isFavorite(
            item
        ) else {
            return
        }

        do {

            let record =
                FavoriteRecord(
                    utilityId:
                        item.rawValue
                )

            context.insert(
                record
            )

            try context.save()

        } catch {

            print(
                "❌ Add favorite failed:",
                error
            )
        }
    }

    func remove(
        _ item: UtilityItem
    ) {

        do {

            let descriptor =
                FetchDescriptor<
                    FavoriteRecord
                >()

            let records =
                try context.fetch(
                    descriptor
                )

            guard let record =
                records.first(
                    where: {

                        $0.utilityId ==
                        item.rawValue
                    }
                )
            else {
                return
            }

            context.delete(
                record
            )

            try context.save()

        } catch {

            print(
                "❌ Remove favorite failed:",
                error
            )
        }
    }

    func toggle(
        _ item: UtilityItem
    ) {

        if isFavorite(
            item
        ) {

            remove(
                item
            )

        } else {

            add(
                item
            )
        }
    }
}
