//
//  AppTab.swift
//  ConvertTimerPro
//
//  Created by Mac Mini on 27/5/26.
//

enum AppTab: Int, CaseIterable {
    case calculator
    case timestamp
    case countdown
    case workingDays
    case timezone

    var title: String {
        switch self {
        case .calculator:
            return "Calculator"
        case .timestamp:
            return "Timestamp"
        case .countdown:
            return "Countdown"
        case .workingDays:
            return "Workdays"
        case .timezone:
            return "Timezone"
        }
    }

    var iconName: String {
        switch self {
        case .calculator:
            return "plus.forwardslash.minus"
        case .timestamp:
            return "clock.arrow.circlepath"
        case .countdown:
            return "timer"
        case .workingDays:
            return "calendar.badge.clock"
        case .timezone:
            return "globe"
        }
    }
}
