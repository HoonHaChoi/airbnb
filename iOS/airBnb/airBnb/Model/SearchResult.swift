//
//  SearchResult.swift
//  airBnb
//
//  Created by HOONHA CHOI on 2021/06/03.
//

import Foundation

struct Rooms: Decodable {
    let rooms: [Room]
}

struct Room: Decodable {
    let id, locationId, hostId, themeId: Int
    let latitude, longitude: Double
    let name, roomAndPropertyType: String
    let avgRating: Double
    let rentalFeePerNight: Int
    let weeklyPriceFactor, monthlyPriceFactor: Double
    let description: String
    let personCapacity, bedrooms, beds, bathrooms: Int
    let images, amenities: [String]
    let numOfReview: Int
    let hostName: String
}
