//
//  SequenceDates.swift
//  airBnb
//
//  Created by HOONHA CHOI on 2021/05/27.
//

import Foundation

struct SequenceDates {
    var start: Date?
    var end: Date?
    
    func show() -> String {
        guard let start = start else {
            return ""
        }
        guard let end = end else {
            return start.convertString()
        }
        return start.convertString() + " - " + end.convertString()
    }
    
    mutating func selectDay(with day: Date) {
        let selectedDate = day
        
        if start == nil && end == nil {
            start = selectedDate
            end = nil
        } else if let _ = start, let _ = end {
            start = nil
            end = nil
        } else if let s = start, end == nil && start == selectedDate {
            start = s
            end = start
        } else if let s = start, end == nil && start != selectedDate {
            if selectedDate < s {
                start = selectedDate
                end = s
            } else {
                start = s
                end = selectedDate
            }
        } else {
            start = nil
            end = nil
        }
    }
    
    mutating func reset() {
        start = nil
        end = nil
    }
    
    func hasValued() -> Bool {
       return start != nil && end != nil
    }
    
    func emptyStartValued() -> Bool {
       return start == nil
    }
    
    func showSelectDate() -> (start: String, end: String) {
        return (start: start?.convertYearMonthDayString() ?? "",
                end: end?.convertYearMonthDayString() ?? "")
    }
}
