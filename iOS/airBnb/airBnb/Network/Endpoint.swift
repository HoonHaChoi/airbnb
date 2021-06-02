//
//  Endpoint.swift
//  airBnb
//
//  Created by HOONHA CHOI on 2021/05/23.
//

import Foundation

enum Endpoint {
    private static let scheme = "http"
    private static let host = "airbnb.clone.r-e.kr"
    private static let searchPath = "/api/search/"
    private static let loadingPath = "/api/rooms"
    
    static func searchLocationURL(text: String) -> URL? {
        var components = URLComponents()
        components.scheme = Endpoint.scheme
        components.host = Endpoint.host
        components.path = searchPath + text
        return components.url
    }
    
    static func searchLoadingURL(query: [URLQueryItem]) -> URL? {
        var components = URLComponents()
        components.scheme = Endpoint.scheme
        components.host = Endpoint.host
        components.path = loadingPath
        components.queryItems = query
        return components.url
    }
    
    static func makeQueryItem(queryData: SearchResultDTO) -> [URLQueryItem] {
        return [
            URLQueryItem(name: "locationId", value: "\(queryData.location)"),
            URLQueryItem(name: "checkIn", value: "\(queryData.checkIn)"),
            URLQueryItem(name: "checkOut", value: "\(queryData.checkOut)"),
            URLQueryItem(name: "priceMin", value: "\(queryData.priceMin)"),
            URLQueryItem(name: "priceMax", value: "\(queryData.priceMax)"),
            URLQueryItem(name: "adults", value: "\(queryData.adults)"),
            URLQueryItem(name: "children", value: "\(queryData.children)"),
            URLQueryItem(name: "infants", value: "\(queryData.infants)")
        ]
    }
}
