//
//  SearchResultHeaderView.swift
//  airBnb
//
//  Created by HOONHA CHOI on 2021/05/30.
//

import UIKit

class SearchResultHeaderView: UICollectionReusableView {
    static var identifier: String {
        return String(describing: self)
    }
    
    static var nib = UINib(nibName: identifier, bundle: nil)
}
