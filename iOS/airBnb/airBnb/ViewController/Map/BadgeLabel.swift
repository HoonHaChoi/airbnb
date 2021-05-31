//
//  BadgeLabel.swift
//  airBnb
//
//  Created by HOONHA CHOI on 2021/05/31.
//

import UIKit


class BadgeLabel: UILabel {
    
    func configure(text: String?) {
        self.text = text
        self.uiAdjustment()
    }
    
    private func uiAdjustment() {
        self.layer.cornerRadius = 10
        self.backgroundColor = .white
        self.textColor = .black
        self.textAlignment = .center
        self.font = .boldSystemFont(ofSize: 15)
    }
    
    func updateFrame() {
        self.frame = CGRect(x: 0, y: 0, width: self.frame.width + 24, height: self.frame.height + 8)
    }
}
