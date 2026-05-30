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
        
        let now = Date()
        
        let calendar =
        Calendar.current
        
        let ageComponents =
        calendar.dateComponents(
            [
                .year,
                .month,
                .day
            ],
            from: birthDate,
            to: now
        )
        
        let totalDays =
        calendar.dateComponents(
            [.day],
            from: birthDate,
            to: now
        ).day ?? 0
        
        var nextBirthday =
        calendar.date(
            bySetting: .year,
            value: calendar.component(
                .year,
                from: now
            ),
            of: birthDate
        ) ?? now
        
        if nextBirthday < now {
            
            nextBirthday =
            calendar.date(
                byAdding: .year,
                value: 1,
                to: nextBirthday
            ) ?? nextBirthday
        }
        
        let daysUntilBirthday =
        calendar.dateComponents(
            [.day],
            from: now,
            to: nextBirthday
        ).day ?? 0
        
        
        return AgeResult(
            years:
                ageComponents.year ?? 0,
            months:
                ageComponents.month ?? 0,
            days:
                ageComponents.day ?? 0,
            totalDays:
                totalDays,
            totalHours:
                totalDays * 24,
            totalMinutes:
                totalDays * 24 * 60,
            nextBirthdayDaysRemaining:
                daysUntilBirthday
        )
    }
}
