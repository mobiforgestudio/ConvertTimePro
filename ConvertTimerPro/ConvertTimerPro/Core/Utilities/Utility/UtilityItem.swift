//
//  UtilityItem.swift
//  ConvertTimerPro
//
//  Created by Mac Mini on 30/5/26.
//

import Foundation

enum UtilityItem:
    String,
    CaseIterable {
    
    case calculator
    case timestamp
    case countdown
    case workdays
    case timezone
    case age
    case dateDifference
    
    var title: String {
        
        switch self {
            
        case .calculator:
            return "Calculator"
            
        case .timestamp:
            return "Timestamp"
            
        case .countdown:
            return "Countdown"
            
        case .workdays:
            return "Workdays"
            
        case .timezone:
            return "Timezone"
            
        case .age:
            return "Age Calculator"
            
        case .dateDifference:
            return "Date Difference"
        }
    }
    
    var subtitle: String {
        
        switch self {
            
        case .calculator:
            return "Perform calculations"
            
        case .timestamp:
            return "Unix timestamp converter"
            
        case .countdown:
            return "Count down to a date"
            
        case .workdays:
            return "Business day calculator"
            
        case .timezone:
            return "Convert between timezones"
            
        case .age:
            return "Calculate exact age"
            
        case .dateDifference:
            return "Compare two dates"
        }
    }
    
    var icon: String {
        
        switch self {
            
        case .calculator:
            return "plus.forwardslash.minus"
            
        case .timestamp:
            return "clock"
            
        case .countdown:
            return "hourglass"
            
        case .workdays:
            return "calendar.badge.clock"
            
        case .timezone:
            return "globe"
            
        case .age:
            return "person"
            
        case .dateDifference:
            return "calendar"
        }
    }
    var category: UtilityCategory {
        
        switch self {
            
        case .timestamp,
                .countdown,
                .timezone:
            
            return .time
            
        case .workdays,
                .age,
                .dateDifference:
            
            return .date
            
        case .calculator:
            
            return .calculation
        }
    }
}

