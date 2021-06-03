//
//  SearchResultViewModel.swift
//  airBnb
//
//  Created by HOONHA CHOI on 2021/06/03.
//

import Foundation
import Combine

final class SearchResultViewModel {
    
    private let searchResultUseCase: SearchReusltConfigurable
    private var cancellable = Set<AnyCancellable>()
    
    @Published private var searchResult: [Room] = []
    @Published private var errorMessage = ""
    
    init(in searchResultUseCase: SearchReusltConfigurable) {
        self.searchResultUseCase = searchResultUseCase
    }
    
    convenience init() {
        let networkManager = SearchAPI()
        self.init(in : SearchResultUseCase(networkManage: networkManager))
    }
    
    func requestSearchResult(from data: SearchResultDTO) {
        searchResultUseCase.requestSearchResult(from: data)
            .sink { complete in
                if case .failure(let error) = complete {
                    self.errorMessage = error.description
                }
            } receiveValue: { rooms in
                self.searchResult = rooms.rooms
            }.store(in: &cancellable)
    }
    
    func fetchError() -> AnyPublisher<String, Never> {
        return $errorMessage
            .dropFirst()
            .eraseToAnyPublisher()
    }
    
    func fetchSearchResultRooms() -> AnyPublisher<[Room], Never> {
        return $searchResult.eraseToAnyPublisher()
    }
}
