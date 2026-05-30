//
//  RecentManager.swift
//  ConvertTimerPro
//
//  Created by Mac Mini on 30/5/26.
//

import Foundation

final class RecentManager {

    static let shared =
        RecentManager()

    private let key =
        "recent.utilities"

    private let maxItems =
        5

    private init() {}

    func save(
        _ item: UtilityItem
    ) {

        var items =
            fetch()

        items.removeAll {
            $0 == item
        }

        items.insert(
            item,
            at: 0
        )

        if items.count > maxItems {

            items =
                Array(
                    items.prefix(
                        maxItems
                    )
                )
        }

        UserDefaults.standard.set(
            items.map(\.rawValue),
            forKey: key
        )
    }

    func fetch()
    -> [UtilityItem] {

        guard let values =
                UserDefaults.standard.array(
                    forKey: key
                ) as? [String]
        else {
            return []
        }

        return values.compactMap {
            UtilityItem(
                rawValue: $0
            )
        }
    }
}
