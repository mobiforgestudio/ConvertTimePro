//
//  TimezoneResult.swift
//  ConvertTimerPro
//
//  Created by Mac Mini on 30/5/26.
//

import Foundation

struct TimezoneResult {

    let sourceDate: Date

    let convertedDate: Date

    let fromTimeZone: TimeZone

    let toTimeZone: TimeZone

    let offsetHours: Int
}
