//
//  SearchResultHeaderView.swift
//  airBnb
//
//  Created by HOONHA CHOI on 2021/05/30.
//

import UIKit

class SearchResultHeaderView: UICollectionReusableView {
    
    static var nib = UINib(nibName: reuseidentifier, bundle: nil)
    
    @IBOutlet weak var searchConditionLabel: UILabel!
    @IBOutlet weak var searchConditionCountLabel: UILabel!
    
    func configure(from condition: String, count: Int) {
        searchConditionLabel.text = condition
        searchConditionCountLabel.text = "\(count)개 이상의 숙소"
    }
}
