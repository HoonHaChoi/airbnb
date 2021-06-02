//
//  KidCountState.swift
//  airBnb
//
//  Created by HOONHA CHOI on 2021/05/28.
//

import Foundation

class KidCountState: ChildProtocol {
    
    @Published var count: Int
    
    init() {
        count = 0
    }
    
    func increase(from: (Int) -> Bool) {
        if from(count) {
            count += 1
        }
    }
    
    func decrease(from: (Int) -> Bool) {
        if from(count) {
            count -= 1
        }
    }
    
    func isNotZero() -> Bool {
        return count > 0
    }
}
