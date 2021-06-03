//
//  SearchResultCell.swift
//  airBnb
//
//  Created by HOONHA CHOI on 2021/05/30.
//

import UIKit
import Combine

class SearchResultCell: UICollectionViewCell {
    static var nib = UINib(nibName: identifier, bundle: nil)
    
    private var cancellable = Set<AnyCancellable>()
    
    @IBOutlet weak var thumbNailImagesStackView: UIStackView!
    @IBOutlet weak var avgRatingLabel: UILabel!
    @IBOutlet weak var roomPropertyLabel: UILabel!
    @IBOutlet weak var roomTitle: UILabel!
    @IBOutlet weak var rentalPriceLabel: UILabel!
    @IBOutlet weak var rentalTotalPriceLabel: UILabel!
    @IBOutlet weak var numOfReview: UILabel!
    
    func configure(from room: Room, days: Int) {
        avgRatingLabel.text = "\(room.avgRating)"
        roomPropertyLabel.text = room.roomAndPropertyType
        roomTitle.text = room.name
        rentalPriceLabel.text = "\(room.rentalFeePerNight.convertWon()) / 박"
        rentalTotalPriceLabel.text = "총액 \((room.rentalFeePerNight * days).convertWon())"
        numOfReview.text = "(후기 \(room.numOfReview)개)"
        imagesLoad(at: room.images)
    }
    
    func imagesLoad(at images: [String]) {
        thumbNailImagesStackView.arrangedSubviews.forEach { view in
            view.removeFromSuperview()
        }
        
        images.forEach { [unowned self] url in
            let imageView = UIImageView()
            imageView.translatesAutoresizingMaskIntoConstraints = false
            thumbNailImagesStackView.addArrangedSubview(imageView)
            
            ImageLoader().load(url: url)
                .receive(on: DispatchQueue.main)
                .sink { imageURL in
                    imageView.image = UIImage(contentsOfFile: imageURL)
                    imageView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
                    imageView.heightAnchor.constraint(equalTo: self.thumbNailImagesStackView.heightAnchor).isActive = true
            }.store(in: &cancellable)
        }
    }
}
