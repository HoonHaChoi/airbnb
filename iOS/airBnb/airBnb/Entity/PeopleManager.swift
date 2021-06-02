//
//  PeopleManager.swift
//  airBnb
//
//  Created by HOONHA CHOI on 2021/05/28.
//

import Foundation
import Combine

enum PeopleTypes: CaseIterable {
    case adult
    case kid
    case baby
}

class PeopleManager {
    
    private var adult: AdultCountState
    private var kid: KidCountState
    private var baby: BabyCountState
    @Published private var totalPeople: (Int, Int)
    
    private var peopleMapper: [PeopleTypes: CountStatable]
    private lazy var people: [CountStatable] = [adult,kid,baby]
    
    private var cancellable = Set<AnyCancellable>()
    
    init() {
        self.adult = AdultCountState()
        self.kid = KidCountState()
        self.baby = BabyCountState()
        self.peopleMapper = [:]
        self.totalPeople = (0, 0)
        createMapper()
        collectPeople()
    }
    
    private func createMapper() {
        self.peopleMapper = Dictionary(uniqueKeysWithValues: zip(PeopleTypes.allCases, people))
    }
    
    func increasePeople(from people: PeopleTypes) {
        peopleMapper[people]?.increase(from: isIncreaseEnabled(for:))
        existOnlyChildren()
    }
    
    func decreasePeople(from people: PeopleTypes) {
        peopleMapper[people]?.decrease(from: isDecreaseEnabled(for:))
        existOnlyChildren()
    }
    
    func relayAuldtCount() -> AnyPublisher<Int, Never> {
        return adult.$count.eraseToAnyPublisher()
    }
    
    func relayKidCount() -> AnyPublisher<Int, Never> {
        return kid.$count.eraseToAnyPublisher()
    }
    
    func relayBabyCount() -> AnyPublisher<Int, Never> {
        return baby.$count.eraseToAnyPublisher()
    }
    
    func relayTotalCount() -> AnyPublisher<(Int,Int), Never> {
        return $totalPeople.eraseToAnyPublisher()
    }
    
    private func collectPeople() {
        return adult.$count.combineLatest(kid.$count)
            .map { $0 + $1 }.combineLatest(baby.$count)
            .map { (guest, baby) in
                return (guest, baby)
            }.sink { (guest, baby) in
                self.totalPeople = (guest ,baby)
            }.store(in: &cancellable)
    }
    
    func isDectedZero() -> AnyPublisher<(adult: Bool,kid: Bool,baby: Bool), Never> {
        adult.$count.combineLatest(kid.$count, baby.$count)
            .map {
                (self.isDecreaseEnabled(for: $0),
                 self.isDecreaseEnabled(for: $1),
                 self.isDecreaseEnabled(for: $2))
            }.eraseToAnyPublisher()
    }
    
    private func isNotZero(count: Int) -> Bool {
        return count != 0
    }
    
    func isDectedFull() -> AnyPublisher<(adult: Bool,kid: Bool,baby: Bool), Never> {
        adult.$count.combineLatest(kid.$count, baby.$count)
            .map {
                (self.isIncreaseEnabled(for: $0),
                 self.isIncreaseEnabled(for: $1),
                 self.isIncreaseEnabled(for: $2))
            }.eraseToAnyPublisher()
    }
    
    private func isNotFull(count: Int) -> Bool {
        return count != 8
    }
    
    private func existOnlyChildren() {
        if adult.isZero() && (baby.isNotZero() || kid.isNotZero()) {
            adult.count += 1
        }
    }
    
    func isNotZeroPeople() -> AnyPublisher<Bool, Never> {
        return adult.$count.map {
            self.isNotZero(count: $0)
        }.eraseToAnyPublisher()
    }
    
    private func isDecreaseEnabled(for count: Int) -> Bool {
        return count > 0
    }
    
    private func isIncreaseEnabled(for count: Int) -> Bool {
        return count < 8
    }
    
    func showHeadCount() -> (adult: Int, kid: Int, baby: Int) {
        return (adult.count, kid.count, baby.count)
    }
}
