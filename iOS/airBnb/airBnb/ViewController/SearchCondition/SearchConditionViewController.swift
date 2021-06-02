//
//  LocationInfoViewController.swift
//  airBnb
//
//  Created by HOONHA CHOI on 2021/05/24.
//

import UIKit
import Combine

class SearchConditionViewController: UIViewController{

    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var checkInOutLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var numOfPeopleLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var skipAndDeleteButton: UIButton!
    
    private var cancellable = Set<AnyCancellable>()
    private var deleteDatesSubject = PassthroughSubject<Void, Never>()
    private var nextViewSubject: PassthroughSubject<Void, Never>?

    private var searchConditionViewModel = SearchConditionViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        bind()
    }
    
    func inject(from manager : SearchManager?,
                subject: PassthroughSubject<Void,Never>,
                state: ScreenState) {
        searchConditionViewModel.update(from: manager, of: state)
        nextViewSubject = subject
        deleteDatesSubject.sink { [weak self] _ in
            self?.searchConditionViewModel.deleteData()
        }.store(in: &cancellable)
    }
        
    private func bind() {
        searchConditionViewModel.releaseSelectLocation()?.sink { [weak self] (selectLocation) in
            self?.locationLabel.text = selectLocation
        }.store(in: &cancellable)
        
        searchConditionViewModel.releaseSelectDates()?.sink { [weak self] (selectDates) in
            self?.checkInOutLabel.text = selectDates
        }.store(in: &cancellable)
        
        searchConditionViewModel.allowSelectDates()?.sink { [weak self] (enable) in
            self?.nextButton.isEnabled = enable
        }.store(in: &cancellable)
        
        searchConditionViewModel.showSkipDeleteText()?.sink { [weak self] (text) in
            self?.skipAndDeleteButton.setTitle(text, for: .normal)
        }.store(in: &cancellable)
        
        searchConditionViewModel.releasePriceRange()?.sink { [weak self] (price) in
            self?.priceLabel.text = price
        }.store(in: &cancellable)
        
        searchConditionViewModel.allowPriceNextButton()?.sink { [weak self] (enable) in
            self?.nextButton.isEnabled = enable
        }.store(in: &cancellable)
        
        searchConditionViewModel.showPeopleTotal()?.sink { [weak self] (guest, baby) in
            let guest = guest == 0 ? "" : "게스트 \(guest)명"
            let baby = baby == 0 ? "" : "유아 \(baby)명"
            self?.numOfPeopleLabel.text =
                guest + " " + baby
        }.store(in: &cancellable)
        
        searchConditionViewModel.allowPeopleNextButton()?.sink { [weak self] (enable) in
            self?.nextButton.isEnabled = enable
            enable ? self?.nextButton.setTitle("검색", for: .normal) :
                self?.nextButton.setTitle("다음", for: .normal)
        }.store(in: &cancellable)
    }
    
    @IBAction func nextButtonTouched(_ sender: UIButton) {
        nextViewSubject?.send()
    }
    
    @IBAction func skipAndDeleteButtonTouched(_ sender: UIButton) {
        searchConditionViewModel.setSkipAndDeleteAction() ?
            self.nextViewSubject?.send() : self.deleteDatesSubject.send()
    }
}
