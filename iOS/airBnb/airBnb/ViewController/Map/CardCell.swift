//
//  CardCell.swift
//  airBnb
//
//  Created by HOONHA CHOI on 2021/05/30.
//

import UIKit
import Combine

class CardCell: UICollectionViewCell {
    static var nib = UINib(nibName: identifier, bundle: nil)
    
    @IBOutlet weak var thumbNailImage: UIImageView!
    @IBOutlet weak var reviewCountLabel: UILabel!
    @IBOutlet weak var avgRatingLabel: UILabel!
    @IBOutlet weak var roomTitle: UILabel!
    @IBOutlet weak var roomPrice: UILabel!
    
    private var cancellable: AnyCancellable?
    
    func configure(from room: Room) {
        reviewCountLabel.text = "(후기 \(room.numOfReview)개)"
        avgRatingLabel.text = "\(room.avgRating)"
        roomTitle.text = room.name
        roomPrice.text = "\(room.rentalFeePerNight.convertWon()) / 박"
        
        cancellable = ImageLoader().load(url: room.images[0])
            .receive(on: DispatchQueue.main)
            .sink { [weak self] imageURL in
                self?.thumbNailImage.image = UIImage(contentsOfFile: imageURL)
            }
    }
}
