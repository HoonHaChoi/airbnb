//
//  NetworkManager.swift
//  airBnb
//
//  Created by HOONHA CHOI on 2021/05/23.
//

import Foundation
import Combine

protocol SearchAPIProtocol {
    func requestLocation<T: Decodable>(from location: String) -> AnyPublisher<T,NetworkError>
    func requestSearchResult<T: Decodable>(from data: SearchResultDTO) -> AnyPublisher<T, NetworkError>
    func requestReservation<T: Decodable>(at id: Int, from data: SearchResultDTO) -> AnyPublisher<T, NetworkError>
}

final class SearchAPI: SearchAPIProtocol {
    
    func requestLocation<T: Decodable>(from location: String) -> AnyPublisher<T,NetworkError> {
        guard let url = Endpoint.searchLocationURL(text: location) else {
            return Fail(error: NetworkError.invalidURL).eraseToAnyPublisher()
        }
        return request(from: url)
    }
    
    func requestSearchResult<T: Decodable>(from data: SearchResultDTO) -> AnyPublisher<T, NetworkError> {
        guard let url = Endpoint.searchLoadingURL(query: Endpoint.makeQueryItem(queryData: data)) else {
            return Fail(error: NetworkError.invalidURL).eraseToAnyPublisher()
        }
        return request(from: url)
    }
    
    func requestReservation<T: Decodable>(at id: Int, from data: SearchResultDTO) -> AnyPublisher<T, NetworkError> {
        guard let url = Endpoint.accommodationInfoURL(id: id, query: Endpoint.makeAccommodationInfoQuery(queryData: data)) else {
            return Fail(error: NetworkError.invalidURL).eraseToAnyPublisher()
        }
        return request(from: url)
    }
    
    private func request<T : Decodable>(from url: URL) -> AnyPublisher<T, NetworkError> {
        let decode = JSONDecoder()
        decode.keyDecodingStrategy = .convertFromSnakeCase
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .mapError { _ in
                NetworkError.invalidRequest
            }
            .flatMap { (data, response) -> AnyPublisher<T, NetworkError> in
                guard let httpResponse = response as? HTTPURLResponse else {
                    return Fail(error: NetworkError.invalidResponse).eraseToAnyPublisher()
                }
                guard 200..<300 ~= httpResponse.statusCode else {
                    return Fail(error:NetworkError.invalidStatusCode(httpResponse.statusCode)).eraseToAnyPublisher()
                }
                return Just(data)
                    .decode(type: T.self, decoder: decode)
                    .mapError { _ in
                        NetworkError.failParsing
                    }.eraseToAnyPublisher()
            }.eraseToAnyPublisher()
    }
}
