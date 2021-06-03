//
//  SearchResultCell.swift
//  airBnb
//
//  Created by HOONHA CHOI on 2021/05/30.
//

import UIKit

class SearchResultCell: UICollectionViewCell {
    static var nib = UINib(nibName: identifier, bundle: nil)
    
    @IBOutlet weak var thumbNailImagesStackView: UIStackView!
    @IBOutlet weak var avgRatingLabel: UILabel!
    @IBOutlet weak var roomPropertyLabel: UILabel!
    @IBOutlet weak var roomTitle: UILabel!
    @IBOutlet weak var rentalPriceLabel: UILabel!
    @IBOutlet weak var rentalTotalPriceLabel: UILabel!
    
    func configure(from room: Room, days: Int) {
        avgRatingLabel.text = "\(room.avgRating)"
        roomPropertyLabel.text = room.roomAndPropertyType
        roomTitle.text = room.name
        rentalPriceLabel.text = "\(room.rentalFeePerNight.convertWon()) / 박"
        rentalTotalPriceLabel.text = "총액 \((room.rentalFeePerNight * days).convertWon())"
    }
}
