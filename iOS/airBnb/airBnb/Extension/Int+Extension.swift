//
//  Int+Extension.swift
//  airBnb
//
//  Created by HOONHA CHOI on 2021/06/03.
//

import Foundation

extension Int {
    func convertWon() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return "₩" + (numberFormatter.string(from: NSNumber(value: self)) ?? "")
    }
}
