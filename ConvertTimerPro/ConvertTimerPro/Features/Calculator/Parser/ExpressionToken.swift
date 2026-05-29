//
//  ExpressionToken.swift
//  ConvertTimerPro
//
//  Created by Mac Mini on 28/5/26.
//

import Foundation

enum ExpressionToken {

    case time(Date)

    case duration(DateComponents)

    case plus

    case minus

    case unknown(String)
}
