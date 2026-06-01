//
//  ClipboardManager.swift
//  ConvertTimerPro
//
//  Created by Mac Mini on 1/6/26.
//

import UIKit

enum ClipboardManager {

    static func copy(
        text: String
    ) {

        UIPasteboard.general.string =
            text

        UINotificationFeedbackGenerator()
            .notificationOccurred(
                .success
            )
    }
}
