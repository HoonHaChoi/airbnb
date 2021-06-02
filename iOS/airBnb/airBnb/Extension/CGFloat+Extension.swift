//
//  Int+Extension.swift
//  airBnb
//
//  Created by HOONHA CHOI on 2021/05/27.
//

import UIKit

extension CGFloat {
    func convertDecimalWon() -> String {
        let number = Int(self * 1000000)
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return "₩" + (numberFormatter.string(from: NSNumber(value: number)) ?? "")
    }
    
    func convertDecimal() -> Int {
        let number = Int(self * 1000000)
        return number
    }
}
