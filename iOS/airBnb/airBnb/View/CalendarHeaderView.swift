//
//  CalendarHeaderView.swift
//  airBnb
//
//  Created by HOONHA CHOI on 2021/05/22.
//

import UIKit

class CalendarHeaderView: UICollectionReusableView {
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configrue()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configrue()
    }
    
    func configrue() {
        addSubview(titleLabel)
        
        titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    func updateLabel(text: String) {
        titleLabel.text = text
    }
}
