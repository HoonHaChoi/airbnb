//
//  SearchLocationUseCase.swift
//  airBnb
//
//  Created by HOONHA CHOI on 2021/05/23.
//

import Foundation
import Combine

protocol SearchLocationConfigurable {
    func requestSearchLocation(from location: String) -> AnyPublisher<SearchLoaction, NetworkError>
}

final class SearchLocationUseCase: SearchLocationConfigurable {
    
    private let networkManager: SearchAPIProtocol
    
    init(networkManage: SearchAPIProtocol) {
        self.networkManager = networkManage
    }
    
    convenience init() {
        self.init(networkManage: SearchAPI())
    }
    
    func requestSearchLocation(from location: String) -> AnyPublisher<SearchLoaction, NetworkError> {
        return networkManager.requestLocation(from: location)
    }
}
