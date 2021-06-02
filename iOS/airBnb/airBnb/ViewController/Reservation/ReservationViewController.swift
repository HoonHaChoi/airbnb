//
//  ReservationViewController.swift
//  airBnb
//
//  Created by HOONHA CHOI on 2021/06/02.
//

import UIKit

class ReservationViewController: UIViewController {

    @IBOutlet weak var checkInfoView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkInfoView.layer.borderColor = UIColor.systemGray5.cgColor
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(closeView(_:))))
    }
    
    @objc private func closeView(_ tapGesture: UITapGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
    }
}
