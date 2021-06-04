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
    
    private let reservationViewModel = ReservationViewModel()
    private var searchResultDTO: SearchResultDTO?
    private var room: Room?
    private var cancellable = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkInfoView.layer.borderColor = UIColor.systemGray5.cgColor
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(closeView(_:))))
        
    }
    
    private func configure(){
        
    }
    
    private func bind() {
        
    }
    
    func injectRoomAndSearchResultDTO(atRoom: Room, atDTO: SearchResultDTO) {
        self.searchResultDTO = atDTO
        self.room = atRoom
    }
        
    @objc private func closeView(_ tapGesture: UITapGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
    }
}
