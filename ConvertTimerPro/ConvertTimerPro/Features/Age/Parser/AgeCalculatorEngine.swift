//
//  AgeCalculatorEngine.swift
//  ConvertTimerPro
//
//  Created by Mac Mini on 30/5/26.
//

import Foundation

final class AgeCalculatorEngine {

    func calculate(
        birthDate: Date
    ) -> AgeResult {

        let calendar =
            Calendar.current

        let now =
            Date()

        let today =
            calendar.startOfDay(
                for: now
            )

        let normalizedBirthDate =
            calendar.startOfDay(
                for: birthDate
            )

        let ageComponents =
            calendar.dateComponents(
                [
                    .year,
                    .month,
                    .day
                ],
                from: normalizedBirthDate,
                to: today
            )

        let totalDays =
            calendar.dateComponents(
                [.day],
                from: normalizedBirthDate,
                to: today
            ).day ?? 0

        let birthMonth =
            calendar.component(
                .month,
                from: normalizedBirthDate
            )

        let birthDay =
            calendar.component(
                .day,
                from: normalizedBirthDate
            )

        let currentYear =
            calendar.component(
                .year,
                from: today
            )

        var nextBirthdayComponents =
            DateComponents()

        nextBirthdayComponents.year =
            currentYear

        nextBirthdayComponents.month =
            birthMonth

        nextBirthdayComponents.day =
            birthDay

        var nextBirthday =
            calendar.date(
                from: nextBirthdayComponents
            ) ?? today

        nextBirthday =
            calendar.startOfDay(
                for: nextBirthday
            )

        if nextBirthday < today {

            nextBirthday =
                calendar.date(
                    byAdding: .year,
                    value: 1,
                    to: nextBirthday
                ) ?? nextBirthday
        }

        let daysUntilNextBirthday =
            calendar.dateComponents(
                [.day],
                from: today,
                to: nextBirthday
            ).day ?? 0

        return AgeResult(
            years: ageComponents.year ?? 0,
            months: ageComponents.month ?? 0,
            days: ageComponents.day ?? 0,
            totalDays: totalDays,
            totalHours: totalDays * 24,
            totalMinutes: totalDays * 24 * 60,
            nextBirthdayDaysRemaining: daysUntilNextBirthday
        )
    }
}
