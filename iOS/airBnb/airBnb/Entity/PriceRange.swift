//
//  PriceRange.swift
//  airBnb
//
//  Created by HOONHA CHOI on 2021/05/27.
//

import UIKit

struct PriceRange {
    private var minimunValue: CGFloat? = nil
    private var maximumValue: CGFloat? = nil
    private let fixedMinimunValue: CGFloat = 0.011
    private let fixedMaximumValue: CGFloat = 1.0
    
    func detectChanged() -> Bool {
        return emptyValued() ||
            minimunValue == fixedMinimunValue &&
            maximumValue == fixedMaximumValue
    }
    
    mutating func change(from slider: PriceSlider) {
        self.minimunValue = slider.lowerValue
        self.maximumValue = slider.upperValue
    }
    
    mutating func reset() {
        self.minimunValue = nil
        self.maximumValue = nil
    }
    
    func emptyValued() -> Bool {
        return minimunValue == nil || maximumValue == nil
    }
    
    func hasValued() -> Bool {
        return minimunValue != nil || maximumValue != nil
    }
    
    func show() -> String {
        guard let min = minimunValue, let max = maximumValue else {
            return ""
        }
        return min.convertDecimalWon() + " - " +
            max.convertDecimalWon()
    }
    
    func showRangePrice() -> (min: Int, max: Int) {
        guard let min = minimunValue,let max = maximumValue else {
            return (min: 11000, max: 1000000)
        }
        return (min.convertDecimal(), max.convertDecimal())
    }
}
