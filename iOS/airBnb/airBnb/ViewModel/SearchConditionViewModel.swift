//
//  LocationInfoViewModel.swift
//  airBnb
//
//  Created by HOONHA CHOI on 2021/05/24.
//

import Foundation
import Combine

enum ScreenState {
    case calerdar
    case price
    case people
}

class SearchConditionViewModel {
    
    private var cancellable = Set<AnyCancellable>()
    private var searchManager: SearchManager?
    private var state: ScreenState
    
    private let skip = "건너뛰기"
    private let delete = "지우기"
    
    init() {
        self.searchManager = nil
        self.state = .calerdar
    }
    
    func update(from manager: SearchManager?, of state: ScreenState) {
        self.searchManager = manager
        self.state = state
    }
    
    func releaseSelectLocation() -> AnyPublisher<String, Never>? {
        return searchManager?.$location
            .eraseToAnyPublisher()
    }
    
    func releaseSelectDates() -> AnyPublisher<String, Never>? {
        return searchManager?.$selectDates
            .map { $0.show() }
            .eraseToAnyPublisher()
    }
    
    func allowSelectDates() -> AnyPublisher<Bool, Never>? {
        return searchManager?.$selectDates
            .map { $0.hasValued() }
            .eraseToAnyPublisher()
    }
    
    func releasePriceRange() -> AnyPublisher<String, Never>? {
        return searchManager?.$priceRange
            .map { $0.show() }
            .eraseToAnyPublisher()
    }
    
    func allowPriceNextButton() -> AnyPublisher<Bool, Never>? {
        return searchManager?.$priceRange
            .map { $0.hasValued() }
            .eraseToAnyPublisher()
    }
    
    func showPeopleTotal() -> AnyPublisher<(Int, Int), Never>? {
        return searchManager?.bindTotalCount()
            .dropFirst()
            .eraseToAnyPublisher()
    }
    
    func allowPeopleNextButton() -> AnyPublisher<Bool, Never>? {
        return searchManager?.bindPeopleNextButtonisEnabled()
    }
    
    func deleteData() {
        searchManager?.reset(in: state)
    }
    
    func showSkipDeleteText() -> AnyPublisher<String, Never>? {
        switch state {
        case .calerdar:
            return searchManager?.$selectDates
                .map { self.desideSkipDelete(to: $0.emptyStartValued()) }
                .eraseToAnyPublisher()
        case .people:
            return Just(skip)
                .eraseToAnyPublisher()
        case .price:
            return searchManager?.$priceRange
                .map { self.desideSkipDelete(to: $0.detectChanged()) }
                .eraseToAnyPublisher()
        }
    }
    
    func setSkipAndDeleteAction() -> Bool {
        guard let manager = searchManager else {
            return false
        }
        switch state {
        case .calerdar:
          return manager.emptySelectDateStartValued()
        case .people:
            return true
        case .price:
            return manager.detectPriceChanged()
        }
    }
    
    private func desideSkipDelete(to bool: Bool) -> String {
        return bool ? skip : delete
    }
}
