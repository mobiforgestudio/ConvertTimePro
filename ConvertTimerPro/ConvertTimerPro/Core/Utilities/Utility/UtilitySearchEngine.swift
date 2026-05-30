//
//  UtilitySearchEngine.swift
//  ConvertTimerPro
//
//  Created by Mac Mini on 30/5/26.
//

import Foundation

final class UtilitySearchEngine {

    func search(
        query: String,
        in items: [UtilityItem]
    ) -> [UtilityItem] {

        let normalizedQuery =
            query
                .trimmingCharacters(
                    in: .whitespacesAndNewlines
                )
                .lowercased()

        guard !normalizedQuery.isEmpty
        else {
            return items
        }

        return items.filter { item in

            item.title
                .lowercased()
                .contains(
                    normalizedQuery
                )
            ||
            item.subtitle
                .lowercased()
                .contains(
                    normalizedQuery
                )
            ||
            item.keywords
                .contains {
                    $0.lowercased()
                        .contains(
                            normalizedQuery
                        )
                }
        }
    }
}
