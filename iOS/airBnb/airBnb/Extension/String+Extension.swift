//
//  String+Extension.swift
//  airBnb
//
//  Created by HOONHA CHOI on 2021/06/04.
//

import Foundation

extension String {
    func changeDateFormat() -> String {
        let date = DateFormatter().convertStringToDate(dateString: self)
        return DateFormatter().convertDateToString(date: date)
    }
}
