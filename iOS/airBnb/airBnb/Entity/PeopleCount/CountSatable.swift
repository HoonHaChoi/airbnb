//
//  CountSatable.swift
//  airBnb
//
//  Created by HOONHA CHOI on 2021/05/28.
//

import Foundation

protocol CountStatable {
    func increase(from: (Int) -> Bool)
    func decrease(from: (Int) -> Bool)
}

protocol AdultProtocol: CountStatable {
    func isZero() -> Bool
}

protocol ChildProtocol: CountStatable {
    func isNotZero() -> Bool
}
