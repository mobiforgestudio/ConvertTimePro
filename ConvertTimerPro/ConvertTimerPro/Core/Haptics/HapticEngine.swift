//
//  HapticEngine.swift
//  ConvertTimerPro
//
//  Created by Mac Mini on 28/5/26.
//

import UIKit

final class HapticEngine {

    // MARK: - Shared

    static let shared =
        HapticEngine()

    // MARK: - Generators

    private let lightImpact =
        UIImpactFeedbackGenerator(
            style: .light
        )

    private let mediumImpact =
        UIImpactFeedbackGenerator(
            style: .medium
        )

    private let notification =
        UINotificationFeedbackGenerator()

    // MARK: - Init

    private init() {

        prepare()
    }

    // MARK: - Public

    func light() {

        lightImpact.impactOccurred()

        lightImpact.prepare()
    }

    func medium() {

        mediumImpact.impactOccurred()

        mediumImpact.prepare()
    }

    func success() {

        notification.notificationOccurred(
            .success
        )

        notification.prepare()
    }

    func warning() {

        notification.notificationOccurred(
            .warning
        )

        notification.prepare()
    }
}

// MARK: - Private

private extension HapticEngine {

    func prepare() {

        lightImpact.prepare()

        mediumImpact.prepare()

        notification.prepare()
    }
}
