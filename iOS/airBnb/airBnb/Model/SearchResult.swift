//
//  SearchResult.swift
//  airBnb
//
//  Created by HOONHA CHOI on 2021/06/03.
//

import Foundation

struct Rooms: Decodable {
    let room: [Room]
}

struct Room: Decodable {
    let id, locationID, hostID, themeID: Int
    let latitude, longitude: Int
    let name, roomAndPropertyType: String
    let avgRating: Double
    let rentalFeePerNight: Int
    let weeklyPriceFactor, monthlyPriceFactor: Double
    let roomDescription: String
    let personCapacity, bedrooms, beds, bathrooms: Int
    let images, amenities: [String]    
}
