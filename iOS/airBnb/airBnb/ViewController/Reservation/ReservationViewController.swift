//
//  ReservationViewController.swift
//  airBnb
//
//  Created by HOONHA CHOI on 2021/06/02.
//

import UIKit
import Combine

class ReservationViewController: UIViewController {
    
    @IBOutlet weak var checkInfoView: UIView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var checkInLabel: UILabel!
    @IBOutlet weak var checkOutLabel: UILabel!
    @IBOutlet weak var numOfPeopleLabel: UILabel!
    
    @IBOutlet weak var forcastStackView: UIStackView!
    @IBOutlet weak var totalPriceLabel: UILabel!
    
    private let reservationViewModel = ReservationViewModel()
    private var searchResultDTO: SearchResultDTO?
    private var room: Room?
    private var cancellable = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        requsetPriceForecast()
        bind()
    }
    
    private func configure(){
        checkInfoView.layer.borderColor = UIColor.systemGray5.cgColor
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(closeView(_:))))
    }
    
    private func requsetPriceForecast() {
        guard let room = room, let dto = searchResultDTO else {
            return
        }
        reservationViewModel.requestReservation(at: room.id, from: dto)
    }
    
    private func bind() {
        reservationViewModel.fetchPriceForecast()
            .receive(on: DispatchQueue.main)
            .sink { sss in
                self.updateUI(to: sss)
            }.store(in: &cancellable)
    }
    
    private func updateUI(to data: [String]) {
        guard let room = room, let dto = searchResultDTO else {
            return
        }
        priceLabel.text = "\(room.rentalFeePerNight.convertWon()) / 박"
        checkInLabel.text = dto.checkIn.changeDateFormat()
        checkOutLabel.text = dto.checkOut.changeDateFormat()
        numOfPeopleLabel.text = "게스트 \(dto.adults + dto.children)명"
        
        data.forEach { forcast in
            let split = forcast.components(separatedBy: ":")
            let key = split[0]
            let value = split[1]
            let horizontalStackView = UIStackView()
            horizontalStackView.alignment = .fill
            horizontalStackView.distribution = .fillEqually
            horizontalStackView.axis = .horizontal
            
            if key == "합계" {
                let lineView = UIView()
                lineView.translatesAutoresizingMaskIntoConstraints = false
                lineView.heightAnchor.constraint(equalToConstant: 1).isActive = true
                lineView.backgroundColor = .systemGray5
                forcastStackView.addArrangedSubview(lineView)
            }
 
            forcastStackView.addArrangedSubview(horizontalStackView)
            
            let leftLabel = UILabel()
            let rightLabel = UILabel()
            rightLabel.textAlignment = .right
            leftLabel.text = key
            rightLabel.text = "\((Int(value) ?? 0).convertWon())"
            
            
            if key == "합계" {
                leftLabel.font = UIFont.systemFont(ofSize: 17, weight: .medium)
                rightLabel.font = UIFont.systemFont(ofSize: 17, weight: .medium)
            }
            horizontalStackView.addArrangedSubview(leftLabel)
            horizontalStackView.addArrangedSubview(rightLabel)
        }
        self.view.layoutIfNeeded()
    }
    
    func injectRoomAndSearchResultDTO(atRoom: Room, atDTO: SearchResultDTO) {
        self.searchResultDTO = atDTO
        self.room = atRoom
    }
    
    @objc private func closeView(_ tapGesture: UITapGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
    }
}
