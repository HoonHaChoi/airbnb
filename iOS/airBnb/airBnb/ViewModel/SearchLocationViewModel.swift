//
//  SearchLocationViewModel.swift
//  airBnb
//
//  Created by HOONHA CHOI on 2021/05/23.
//

import Foundation
import Combine

final class SearchLocationViewModel {
    
    private let searchLocationUseCase: SearchLocationConfigurable
    private var cancellable = Set<AnyCancellable>()
    
    @Published private var searchResult: [LocationList] = []
    @Published private var errorMessage = ""
    
    init(searchLocation: SearchLocationConfigurable) {
        self.searchLocationUseCase = searchLocation
    }
    
    convenience init() {
        let networkManager = SearchAPI()
        self.init(searchLocation: SearchLocationUseCase(networkManage: networkManager))
    }
    
    func requestSearch(from location: String) {
        searchLocationUseCase.requestSearchLocation(from: location)
            .timeout(.seconds(10), scheduler: DispatchQueue.global())
            .replaceError(with: SearchLoaction.init(locationList: []))
            .sink(receiveValue: { [weak self] (result) in
                self?.searchResult = result.locationList
            }).store(in: &cancellable)
    }
    
    func fetchSearchResult() -> AnyPublisher<[LocationList], Never> {
        return $searchResult
            .eraseToAnyPublisher()
    }
    
    func fetchError() -> AnyPublisher<String, Never> {
        return $errorMessage
            .dropFirst()
            .eraseToAnyPublisher()
    }
}
