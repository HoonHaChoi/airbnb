//
//  CalendarHelper.swift
//  airBnb
//
//  Created by HOONHA CHOI on 2021/05/22.
//

import Foundation

class CalendarHelper {
    private let oneYearRange = (0..<12)
    private let calendar = Calendar.current
    private let dateFormatter = DateFormatter()
    
    private(set) var month: [String] = []
    private(set) var days: [[Date?]] = []
    
    init() {
        oneYearRange.forEach { (value) in
            let monthDate = calendar.date(byAdding: .month, value: value, to: Date()) ?? Date()
            let convertMonthString = dateFormatter.convertCalenderHeaderString(date: monthDate)
            month.append(convertMonthString)
            days.append(makeDays(date: monthDate))
        }
    }
    
    private  func makeDays(date: Date) -> [Date?] {
        var days: [Date?] = []
        let dayCount = daysInMonth(date: date)
        let firstDay = firstDayOfMonth(date: date)
        let startingSpaces = weekDayCount(date: firstDay)
        (0..<dayCount + startingSpaces).forEach { (count) in
            checkFirstDayRange(day: count, spaceInt: startingSpaces) ?
                days.append(nil) :
                days.append(createDay(with: count - startingSpaces, firstDay: firstDay))
        }
        return days
    }
    
    private func createDay(with count: Int, firstDay: Date) -> Date {
        return calendar.date(byAdding: .day, value: count, to: firstDay) ?? Date()
    }
    
    private func checkFirstDayRange(day: Int, spaceInt: Int) -> Bool {
        return day < spaceInt
    }
    
    private func daysInMonth(date: Date) -> Int {
        let range = calendar.range(of: .day, in: .month, for: date)!
        return range.count
    }
    
    private func firstDayOfMonth(date: Date) -> Date {
        let components = calendar.dateComponents([.year, .month], from: date)
        return calendar.date(from: components) ?? Date()
    }
    
    private func weekDayCount(date: Date) -> Int {
        let components = calendar.dateComponents([.weekday], from: date)
        return (components.weekday ?? 1) - 1
    }
}
