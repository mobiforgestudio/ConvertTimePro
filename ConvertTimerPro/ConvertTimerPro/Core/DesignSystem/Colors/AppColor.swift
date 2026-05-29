//
//  AppColor.swift
//  ConvertTimerPro
//
//  Created by Mac Mini on 27/5/26.
//

import UIKit

enum AppColor {

    // MARK: - Background

    enum Background {

        /// Main app background
        static let primary = UIColor(
            red: 12 / 255,
            green: 12 / 255,
            blue: 14 / 255,
            alpha: 1
        )

        /// Slightly elevated background
        static let secondary = UIColor(
            red: 18 / 255,
            green: 18 / 255,
            blue: 22 / 255,
            alpha: 1
        )
    }

    // MARK: - Surface

    enum Surface {

        /// Main card surface
        static let card = UIColor(
            red: 28 / 255,
            green: 28 / 255,
            blue: 32 / 255,
            alpha: 0.78
        )

        /// Elevated floating surface
        static let elevated = UIColor(
            red: 38 / 255,
            green: 38 / 255,
            blue: 44 / 255,
            alpha: 0.92
        )

        /// Input field surface
        static let input = UIColor(
            red: 22 / 255,
            green: 22 / 255,
            blue: 26 / 255,
            alpha: 1
        )

        /// Glass overlay
        static let glassOverlay = UIColor.white.withAlphaComponent(0.04)
    }

    // MARK: - Border

    enum Border {

        static let subtle = UIColor.white.withAlphaComponent(0.06)

        static let ultraSubtle = UIColor.white.withAlphaComponent(0.03)
    }
    // MARK: - Text

    enum Text {

        static let primary = UIColor(
            white: 0.96,
            alpha: 1
        )

        static let secondary = UIColor(
            white: 0.72,
            alpha: 1
        )

        static let tertiary = UIColor(
            white: 0.5,
            alpha: 1
        )

        static let accent = UIColor(
            red: 210 / 255,
            green: 210 / 255,
            blue: 255 / 255,
            alpha: 1
        )
    }

    // MARK: - Accent

    enum Accent {

        /// Main brand purple
        static let primary = UIColor(
            red: 140 / 255,
            green: 82 / 255,
            blue: 255 / 255,
            alpha: 1
        )

        /// Blue accent
        static let blue = UIColor(
            red: 88 / 255,
            green: 166 / 255,
            blue: 255 / 255,
            alpha: 1
        )

        /// Glow effect
        static let glow = UIColor(
            red: 160 / 255,
            green: 120 / 255,
            blue: 255 / 255,
            alpha: 0.35
        )

        /// Gradient start
        static let gradientStart = UIColor(
            red: 120 / 255,
            green: 90 / 255,
            blue: 255 / 255,
            alpha: 1
        )

        /// Gradient end
        static let gradientEnd = UIColor(
            red: 80 / 255,
            green: 170 / 255,
            blue: 255 / 255,
            alpha: 1
        )
    }

    // MARK: - Semantic

    enum Semantic {

        static let success = UIColor(
            red: 52 / 255,
            green: 199 / 255,
            blue: 89 / 255,
            alpha: 1
        )

        static let warning = UIColor(
            red: 255 / 255,
            green: 159 / 255,
            blue: 10 / 255,
            alpha: 1
        )

        static let error = UIColor(
            red: 255 / 255,
            green: 69 / 255,
            blue: 58 / 255,
            alpha: 1
        )
    }

    // MARK: - Calculator Syntax

    enum Syntax {

        static let time = UIColor(
            red: 90 / 255,
            green: 170 / 255,
            blue: 255 / 255,
            alpha: 1
        )

        static let duration = UIColor(
            red: 120 / 255,
            green: 220 / 255,
            blue: 140 / 255,
            alpha: 1
        )

        static let operation = UIColor(
            red: 200 / 255,
            green: 120 / 255,
            blue: 255 / 255,
            alpha: 1
        )

        static let keyword = UIColor(
            red: 255 / 255,
            green: 190 / 255,
            blue: 90 / 255,
            alpha: 1
        )
    }
}
