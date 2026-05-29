//
//  TimestampToken.swift
//  ConvertTimerPro
//
//  Created by Mac Mini on 29/5/26.
//

import Foundation

enum TimestampToken {

    case now

    case unix(Date)

    case plus

    case minus

    case duration(DateComponents)
}
