//
//  SearchResultUseCase.swift
//  airBnb
//
//  Created by HOONHA CHOI on 2021/06/03.
//

import Foundation
import Combine

protocol SearchReusltConfigurable {
    func requestSearchResult(from data: SearchResultDTO) -> AnyPublisher<Rooms, NetworkError>
}

final class SearchResultUseCase: SearchReusltConfigurable {
    
    private let networkManager: SearchAPIProtocol
    
    init(networkManage: SearchAPIProtocol) {
        self.networkManager = networkManage
    }
    
    convenience init() {
        self.init(networkManage: SearchAPI())
    }
    
    func requestSearchResult(from data: SearchResultDTO) -> AnyPublisher<Rooms, NetworkError> {
        return networkManager.requestSearchResult(from: data)
    }
}
