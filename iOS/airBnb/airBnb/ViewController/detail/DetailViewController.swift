//
//  DetailViewController.swift
//  airBnb
//
//  Created by HOONHA CHOI on 2021/06/01.
//

import UIKit
import Combine

class DetailViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var detailImageStackView: UIStackView!
    @IBOutlet weak var roomTitleLable: UILabel!
    @IBOutlet weak var avgRatingLabel: UILabel!
    @IBOutlet weak var reviewCountLabel: UILabel!
    @IBOutlet weak var roomPropertyTypeLable: UILabel!
    @IBOutlet weak var hostName: UILabel!
    @IBOutlet weak var roomInfoLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var roomPriceLabel: UILabel!
    @IBOutlet weak var selectDatesLabel: UILabel!
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.backgroundColor = .white
        button.tintColor = .black
        button.layer.cornerRadius = 22
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(closeView(_:)), for: .touchUpInside)
        button.addShadow(offset: CGSize.init(width: 0, height: 3), color: UIColor.black, radius: 2.0, opacity: 0.35)
        return button
    }()
    
    private var room: Room?
    private var searchResultDTO: SearchResultDTO?
    private var cancellable = Set<AnyCancellable>()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = true
        navigationController?.navigationBar.isHidden = true
        scrollView.contentInsetAdjustmentBehavior = .never
   
        view.addSubview(button)
        button.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        button.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24).isActive = true
        button.widthAnchor.constraint(equalToConstant: 44).isActive = true
        button.heightAnchor.constraint(equalToConstant: 44).isActive = true

        showRoomInfo()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func injectRoomInfo(at room: Room, from dto: SearchResultDTO) {
        self.room = room
        self.searchResultDTO = dto
    }
    
    func showRoomInfo() {
        guard let room = room,let dto = searchResultDTO  else {
            return
        }
        roomTitleLable.text = room.name
        avgRatingLabel.text = "\(room.avgRating)"
        reviewCountLabel.text = "(후기 \(room.numOfReview)개)"
        roomPropertyTypeLable.text = room.roomAndPropertyType
        hostName.text = "호스트: " + room.hostName
        roomInfoLabel.text  = "최대인원 \(room.personCapacity)명 침실 \(room.bedrooms)개 침대 \(room.beds)개 욕실 \(room.bathrooms)개"
        descriptionLabel.text = room.description
        
        roomPriceLabel.text = room.rentalFeePerNight.convertWon() + "/ 박"
        selectDatesLabel.text = dto.showCheckDate().start.changeDateFormat() + " - " + dto.showCheckDate().end.changeDateFormat()
        
        room.images.forEach { url in
            let imageView = UIImageView()
            
            detailImageStackView.addArrangedSubview(imageView)
            ImageLoader().load(url: url)
                .receive(on: DispatchQueue.main)
                .sink { [unowned self] imageURL in
                    imageView.image = UIImage(contentsOfFile: imageURL)
                    imageView.heightAnchor.constraint(equalTo: self.detailImageStackView.heightAnchor).isActive = true
                    imageView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
                }.store(in: &cancellable)
        }
    }
    
    @IBAction func reservationButtonTouched(_ sender: UIButton) {
        let reservationViewController = UIStoryboard.create(identifier: ReservationViewController.self, name: "Reservation")
        reservationViewController.modalPresentationStyle = .overFullScreen
        
        guard let room = room, let dto = searchResultDTO else {
            return
        }
        reservationViewController.injectRoomAndSearchResultDTO(atRoom: room, atDTO: dto)
        self.present(reservationViewController, animated: true, completion: nil)
    }
    
    @objc func closeView(_ button: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
}
