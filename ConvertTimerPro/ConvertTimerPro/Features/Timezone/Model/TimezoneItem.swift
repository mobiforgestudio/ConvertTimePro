//
//  TimezoneItem.swift
//  ConvertTimerPro
//
//  Created by Mac Mini on 30/5/26.
//

import Foundation

enum TimezoneItem:
    String,
    CaseIterable {

    case utc
    case gmt7
    case est
    case pst
    case jst

    var title: String {

        switch self {

        case .utc:
            return "UTC"

        case .gmt7:
            return "GMT+7"

        case .est:
            return "EST"

        case .pst:
            return "PST"

        case .jst:
            return "JST"
        }
    }

    var timeZone: TimeZone {

        switch self {

        case .utc:
            return TimeZone(
                secondsFromGMT: 0
            )!

        case .gmt7:
            return TimeZone(
                secondsFromGMT: 7 * 3600
            )!

        case .est:
            return TimeZone(
                identifier:
                    "America/New_York"
            )!

        case .pst:
            return TimeZone(
                identifier:
                    "America/Los_Angeles"
            )!

        case .jst:
            return TimeZone(
                secondsFromGMT: 9 * 3600
            )!
        }
    }
}
