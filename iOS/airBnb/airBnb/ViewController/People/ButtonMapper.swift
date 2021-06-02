//
//  ButtonMapper.swift
//  airBnb
//
//  Created by HOONHA CHOI on 2021/05/28.
//

import Foundation
import UIKit

class ButtonMapper {

    private var map: [UIButton: PeopleTypes]
    
    init(from buttons: [UIButton]) {
        self.map = Dictionary(uniqueKeysWithValues: zip(buttons, PeopleTypes.allCases))
    }
    subscript(button: UIButton) -> PeopleTypes? {
        return map[button]
    }
}
