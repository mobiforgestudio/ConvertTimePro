//
//  ExpressionSuggestion.swift
//  ConvertTimerPro
//
//  Created by Mac Mini on 28/5/26.
//

import Foundation

import Foundation

enum SuggestionBehavior {

    case replace

    case append
}

struct ExpressionSuggestion {

    let title: String

    let expression: String

    let behavior: SuggestionBehavior
}
