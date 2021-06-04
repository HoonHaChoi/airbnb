//
//  ReservationUseCase.swift
//  airBnb
//
//  Created by HOONHA CHOI on 2021/06/04.
//

import Foundation
import Combine

protocol ReservationConfigurable {
    func requestReservationInfo(at id: Int, from data: SearchResultDTO) -> AnyPublisher<[String], NetworkError>
}

class ReservationUseCase: ReservationConfigurable {
    
    private let networkManager: SearchAPIProtocol
    
    init(networkManage: SearchAPIProtocol) {
        self.networkManager = networkManage
    }
    
    convenience init() {
        self.init(networkManage: SearchAPI())
    }
    
    func requestReservationInfo(at id: Int, from data: SearchResultDTO) -> AnyPublisher<[String], NetworkError> {
        return networkManager.requestReservation(at: id, from: data)
    }
}
