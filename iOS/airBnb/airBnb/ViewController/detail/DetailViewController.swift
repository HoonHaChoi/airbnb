//
//  DetailViewController.swift
//  airBnb
//
//  Created by HOONHA CHOI on 2021/06/01.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var detailImageView: UIImageView!
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.backgroundColor = .white
        button.tintColor = .black
        button.layer.cornerRadius = 22
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(closeView(_:)), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = true
        navigationController?.navigationBar.isHidden = true
        scrollView.contentInsetAdjustmentBehavior = .never
   
        view.addSubview(button)
        button.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        button.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24).isActive = true
        button.widthAnchor.constraint(equalToConstant: 44).isActive = true
        button.heightAnchor.constraint(equalToConstant: 44).isActive = true

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func reservationButtonTouched(_ sender: UIButton) {
        let reservationViewController = UIStoryboard.create(identifier: ReservationViewController.self, name: "Reservation")
        reservationViewController.modalPresentationStyle = .overFullScreen
        self.present(reservationViewController, animated: true, completion: nil)
    }
    
    @objc func closeView(_ button: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
}
