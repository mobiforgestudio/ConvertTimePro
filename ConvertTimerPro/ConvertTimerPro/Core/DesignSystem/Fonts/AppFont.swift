//
//  AppFont.swift
//  ConvertTimerPro
//
//  Created by Mac Mini on 27/5/26.
//

import UIKit

enum AppFont {

    // MARK: - Hero

    /// Main calculation result
//    static func hero() -> UIFont {
//        UIFont.systemFont(
//            ofSize: 64,
//            weight: .bold
//        )
//    }
    
    static func hero() -> UIFont {
        UIFont.systemFont(
            ofSize: 64,
            weight: .bold
        ).rounded()
    }

    /// Large countdown / important values
    static func display() -> UIFont {
        UIFont.systemFont(
            ofSize: 48,
            weight: .bold
        )
    }

    // MARK: - Titles

    static func largeTitle() -> UIFont {
        UIFont.systemFont(
            ofSize: 34,
            weight: .bold
        )
    }

    static func title1() -> UIFont {
        UIFont.systemFont(
            ofSize: 28,
            weight: .bold
        )
    }

    static func title2() -> UIFont {
        UIFont.systemFont(
            ofSize: 22,
            weight: .semibold
        )
    }

    static func title3() -> UIFont {
        UIFont.systemFont(
            ofSize: 18,
            weight: .semibold
        )
    }

    // MARK: - Body

    static func body() -> UIFont {
        UIFont.systemFont(
            ofSize: 16,
            weight: .regular
        )
    }

    static func bodyMedium() -> UIFont {
        UIFont.systemFont(
            ofSize: 16,
            weight: .medium
        )
    }

    static func bodySemibold() -> UIFont {
        UIFont.systemFont(
            ofSize: 16,
            weight: .semibold
        )
    }

    // MARK: - Secondary

    static func caption() -> UIFont {
        UIFont.systemFont(
            ofSize: 14,
            weight: .regular
        )
    }

    static func captionMedium() -> UIFont {
        UIFont.systemFont(
            ofSize: 14,
            weight: .medium
        )
    }

    static func small() -> UIFont {
        UIFont.systemFont(
            ofSize: 12,
            weight: .regular
        )
    }

    // MARK: - Monospaced

    /// Expression input
    static func expressionInput() -> UIFont {
        UIFont.monospacedSystemFont(
            ofSize: 24,
            weight: .medium
        )
    }

    /// Inline parser suggestions
    static func expressionSuggestion() -> UIFont {
        UIFont.monospacedSystemFont(
            ofSize: 18,
            weight: .regular
        )
    }

    /// Technical output / timestamp
    static func technical() -> UIFont {
        UIFont.monospacedSystemFont(
            ofSize: 16,
            weight: .regular
        )
    }

    // MARK: - Buttons

    static func button() -> UIFont {
        UIFont.systemFont(
            ofSize: 16,
            weight: .semibold
        )
    }

    static func chip() -> UIFont {
        UIFont.systemFont(
            ofSize: 14,
            weight: .medium
        )
    }
}
