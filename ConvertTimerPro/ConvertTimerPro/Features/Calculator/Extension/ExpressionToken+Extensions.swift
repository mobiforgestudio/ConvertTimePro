//
//  ExpressionToken+Extensions.swift
//  ConvertTimerPro
//
//  Created by Mac Mini on 28/5/26.
//

import Foundation

extension ExpressionToken {

    var isOperator: Bool {

        switch self {

        case .plus,
             .minus:

            return true

        default:

            return false
        }
    }

    var isEditableValue: Bool {

        switch self {

        case .time,
             .duration,
             .unknown:

            return true

        default:

            return false
        }
    }
}
