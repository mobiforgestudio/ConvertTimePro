//
//  ExpressionGrammarValidator.swift
//  ConvertTimerPro
//
//  Created by Mac Mini on 28/5/26.
//

import Foundation

final class ExpressionGrammarValidator {

    func validate(
        tokens: [TokenizedExpression]
    ) -> ValidationResult {

        guard !tokens.isEmpty else {
            return .valid
        }

        for index in 0..<tokens.count {

            let current = tokens[index]

            let next = index + 1 < tokens.count
                ? tokens[index + 1]
                : nil

            if current.token.isOperator,
               next?.token.isOperator == true {

                return .invalid(token: next!)
            }

            if case .unknown = current.token {
                return .invalid(token: current)
            }

            // NOTE:
            // Ending with operator is incomplete, not invalid.
            // Example: "20:20 + 1h +"
            // User may still be typing.
        }

        return .valid
    }
}

extension ExpressionGrammarValidator {

    enum ValidationResult {
        case valid
        case invalid(token: TokenizedExpression)
    }
}
