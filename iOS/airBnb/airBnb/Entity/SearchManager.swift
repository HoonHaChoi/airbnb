//
//  SearchManager.swift
//  airBnb
//
//  Created by HOONHA CHOI on 2021/05/23.
//

import Foundation
import Combine

class SearchManager {
     
    @Published private(set) var location: String
    @Published private(set) var selectDates: SequenceDates
    @Published private(set) var priceRange: PriceRange
    @Published private(set) var numberOfPleple: PeopleManager
    
    private var cancell: AnyCancellable?
    
    init() {
        location = ""
        selectDates = .init(start: nil, end: nil)
        priceRange = .init()
        numberOfPleple = .init()
    }
    
    func selectLocation(from location: String) {
        self.location = location
    }
    
    func selectDay(from day: Date) {
        selectDates.selectDay(with: day)
    }
    
    func reset(in state: ScreenState) {
        switch state {
        case .calerdar:
            selectDates.reset()
            NotificationCenter.default.post(name: .seletDatesReset, object: nil)
        case .price:
            priceRange.reset()
            NotificationCenter.default.post(name: .priceReset, object: nil)
        case .people:
            break
        }
    }
    
    func emptySelectDateStartValued() -> Bool {
        return selectDates.emptyStartValued()
    }
    
    func detectPriceChanged() -> Bool {
        return priceRange.detectChanged()
    }
    
    func changePrice(from price: PriceSlider) {
        priceRange.change(from: price)
    }
    
    func increasePeople(from type: PeopleTypes) {
        numberOfPleple.increasePeople(from: type)
    }

    func decreasePeoeple(from type: PeopleTypes) {
        numberOfPleple.decreasePeople(from: type)
    }
    
    func bindAuldtCount() -> AnyPublisher<Int, Never> {
        return numberOfPleple.relayAuldtCount()
    }
    
    func bindKidCount() -> AnyPublisher<Int, Never> {
        return numberOfPleple.relayKidCount()
    }
    
    func bindBabyCount() -> AnyPublisher<Int, Never> {
        return numberOfPleple.relayBabyCount()
    }
    
    func bindTotalCount() -> AnyPublisher<(Int, Int), Never> {
        return numberOfPleple.relayTotalCount()
    }
    
    func bindMinusButtonisEnanbled() -> AnyPublisher<(adult: Bool,kid: Bool,baby: Bool), Never> {
        return numberOfPleple.isDectedZero()
    }
    
    func bindPlusButtonisEnanbled() -> AnyPublisher<(adult: Bool,kid: Bool,baby: Bool), Never> {
        return numberOfPleple.isDectedFull()
    }
    
    func bindPeopleNextButtonisEnabled() -> AnyPublisher<Bool, Never> {
        return numberOfPleple.isNotZeroPeople()
    }
    
    func fetchQueryString() -> (location: Int, checkIn: String, checkOut: String, priceMin: Int, priceMax: Int, adults: Int, children: Int, infants: Int) {
        return (location: 20,
                checkIn: selectDates.showSelectDate().start,
                checkOut: selectDates.showSelectDate().end,
                priceMin: priceRange.showRangePrice().min,
                priceMax: priceRange.showRangePrice().max,
                adults: numberOfPleple.showHeadCount().adult,
                children: numberOfPleple.showHeadCount().kid,
                infants: numberOfPleple.showHeadCount().baby)
    }
}
