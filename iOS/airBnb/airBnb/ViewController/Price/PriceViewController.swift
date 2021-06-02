//
//  PriceSliderViewController.swift
//  airBnb
//
//  Created by HOONHA CHOI on 2021/05/24.
//

import UIKit
import Combine

class PriceViewController: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var priceMinLabel: UILabel!
    @IBOutlet weak var priceMaxLabel: UILabel!
    @IBOutlet weak var priceAvgLabel: UILabel!
    private lazy var rangeSlider: PriceSlider = {
        let slider = PriceSlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.addTarget(self,
                         action: #selector(priceSliderValueChanged(_:)),
                         for: .valueChanged)
        return slider
    }()
    
    private let nextViewControllerSubject = PassthroughSubject<Void,Never>()
    private var cancellable = Set<AnyCancellable>()
    
    private var searchConditionViewController: SearchConditionViewController?
    private var searchManager: SearchManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureRangeView()
        bind()
        NotificationCenter.default.addObserver(self, selector: #selector(resetPriceSliderLabel(_:)), name: .priceReset, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addContainerView()
    }

    override func viewDidLayoutSubviews() {
        rangeSlider.updateLayerFrames()
    }
    
    func configure(for search: SearchManager, from viewController: SearchConditionViewController) {
        self.searchManager = search
        self.searchConditionViewController = viewController
    }
    
    private func configureRangeView() {
        view.addSubview(rangeSlider)
        rangeSlider.translatesAutoresizingMaskIntoConstraints = false
        rangeSlider.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        rangeSlider.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        rangeSlider.topAnchor.constraint(equalTo: priceAvgLabel.bottomAnchor, constant: 50).isActive = true
        rangeSlider.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    private func addContainerView() {
        guard let controller = searchConditionViewController,
              let searchManager = searchManager else {
            return
        }
        controller.inject(from: searchManager,
                          subject: nextViewControllerSubject,
                          state: .price)
        addChild(controller)
        controller.view.frame = containerView.bounds
        containerView.addSubview(controller.view)
    }
    
    private func bind() {
        nextViewControllerSubject.sink { [weak self] _ in
            guard let self = self, let searchManager = self.searchManager, let locationInfo = self.searchConditionViewController else {
                return
            }
            let peopleViewController = UIStoryboard.create(identifier: PeopleViewController.self, name: "People")
            peopleViewController.configure(for: searchManager, from: locationInfo)
            self.navigationController?.pushViewController(peopleViewController, animated: true)
        }.store(in: &cancellable)
    }
    
    @objc private func priceSliderValueChanged(_ priceSlider: PriceSlider) {
        searchManager?.changePrice(from: priceSlider)
        
        DispatchQueue.main.async { [weak self] in
            self?.priceMinLabel.text = priceSlider.lowerValue.converNumberFormatter()
            self?.priceMaxLabel.text = priceSlider.upperValue.converNumberFormatter()
            self?.priceAvgLabel.text = priceSlider.calculateAvg().converNumberFormatter()
        }
    }
    
    @objc private func resetPriceSliderLabel(_ notification: Notification) {
        rangeSlider.reset()
        priceMinLabel.text = "₩11,000"
        priceMaxLabel.text = "₩1,000,000"
        priceAvgLabel.text = "₩505,499"
    }
}
