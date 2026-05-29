//
//  SyntaxHighlighting.swift
//  ConvertTimerPro
//
//  Created by Mac Mini on 29/5/26.
//

import UIKit
import Foundation

protocol SyntaxHighlighting {
    func highlight(
        text: String,
        validationErrors: [ExpressionValidationError]
    ) -> NSAttributedString
}
