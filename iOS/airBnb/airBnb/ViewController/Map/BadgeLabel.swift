//
//  BadgeLabel.swift
//  airBnb
//
//  Created by HOONHA CHOI on 2021/05/31.
//

import UIKit


class BadgeLabel: UILabel {

//    private let padding = UIEdgeInsets(top: 4, left: 12, bottom: 4, right: 12)
//
//    override func drawText(in rect: CGRect) {
//        let paddingRect = rect.inset(by: padding)
//        super.drawText(in: paddingRect)
//    }
//
//    override var intrinsicContentSize: CGSize {
//        var contentSize = super.intrinsicContentSize
//        contentSize.height += padding.top + padding.bottom
//        contentSize.width += padding.left + padding.right
//        return contentSize
//    }
    
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
