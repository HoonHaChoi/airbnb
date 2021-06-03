//
//  SearchResultDTO.swift
//  airBnb
//
//  Created by HOONHA CHOI on 2021/06/03.
//

import Foundation

struct SearchResultDTO {
    let location: Int
    let checkIn: String
    let checkOut: String
    let priceMin: Int
    let priceMax: Int
    let adults: Int
    let children: Int
    let infants: Int
    
    init(data : (location: Int, checkIn: String, checkOut: String, priceMin: Int, priceMax: Int, adults: Int, children: Int, infants: Int)) {
        self.location = data.location
        self.checkIn = data.checkIn
        self.checkOut = data.checkOut
        self.priceMin = data.priceMin
        self.priceMax = data.priceMax
        self.adults = data.adults
        self.children = data.children
        self.infants = data.infants
    }
    
    func showSearchCondition() -> String {
        return "어딘가・" + "\(checkIn.changeDateFormat())" + " - " + "\(checkOut.changeDateFormat())" + "・게스트 " + "\(adults+children)" + "명"
    }
    
    func showCheckDate() -> (start: String, end: String) {
        return (start: checkIn, end:checkOut)
    }
    
    
}
