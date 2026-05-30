//
//  AgeViewModel.swift
//  ConvertTimerPro
//
//  Created by Mac Mini on 30/5/26.
//

import Foundation

final class AgeViewModel {

    private let engine =
        AgeCalculatorEngine()

    var birthDate =
        Calendar.current.date(
            byAdding: .year,
            value: -30,
            to: Date()
        ) ?? Date()

    func calculate()
    -> AgeResult {

        engine.calculate(
            birthDate: birthDate
        )
    }
}
