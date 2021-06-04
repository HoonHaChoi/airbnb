//
//  ReservationViewModel.swift
//  airBnb
//
//  Created by HOONHA CHOI on 2021/06/04.
//

import Foundation
import Combine

class ReservationViewModel {
    
    private let reservationUseCase: ReservationConfigurable
    private var cancellable = Set<AnyCancellable>()
    
    @Published private var errorMessage: String = ""
    @Published private var priceForecast: [String:Int] = [:]
    
    init(in reservationUseCase: ReservationConfigurable) {
        self.reservationUseCase = reservationUseCase
    }
    
    convenience init() {
        let networkManger = SearchAPI()
        self.init(in: ReservationUseCase(networkManage: networkManger))
     }
    
    func requestReservation(at id: Int, from searchResultDTO: SearchResultDTO) {
        reservationUseCase.requestReservationInfo(at: id, from: searchResultDTO)
            .sink { complete in
                if case .failure(let error) = complete {
                    self.errorMessage = error.description
                }
            } receiveValue: { forecast in
                self.priceForecast = forecast
            }.store(in: &cancellable)
    }
    
    func fetchError() -> AnyPublisher<String, Never> {
        return $errorMessage
            .dropFirst()
            .eraseToAnyPublisher()
    }
    
    func fetchPriceForecast() -> AnyPublisher<[String:Int], Never> {
        return $priceForecast.eraseToAnyPublisher()
    }
    
}
