//
//  PeopleViewController.swift
//  airBnb
//
//  Created by HOONHA CHOI on 2021/05/28.
//

import UIKit
import Combine

class PeopleViewController: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var adultCountLabel: UILabel!
    @IBOutlet weak var kidCountLabel: UILabel!
    @IBOutlet weak var babyCountLabel: UILabel!
    
    private let nextViewControllerSubject = PassthroughSubject<Void,Never>()
    private var cancellable = Set<AnyCancellable>()
    
    private var searchConditionViewController : SearchConditionViewController?
    private var searchManager: SearchManager?
    @IBOutlet var buttonsViewModel: ButtonsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonsViewModel.makeButtonsMapper()
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addContainerView()
    }
    
    private func addContainerView() {
        guard let controller = searchConditionViewController,
              let searchManager = searchManager else {
            return
        }
        controller.inject(from: searchManager,
                          subject: nextViewControllerSubject,
                          state: .people)
        addChild(controller)
        controller.view.frame = containerView.bounds
        containerView.addSubview(controller.view)
    }
    
    func configure(for search: SearchManager, from viewController: SearchConditionViewController) {
        self.searchManager = search
        self.searchConditionViewController = viewController
    }
    
    private func bind() {
        buttonsViewModel.bind { [weak self] (type, action) in
            switch action {
            case .plus:
                self?.searchManager?.increasePeople(from: type)
            case .minus:
                self?.searchManager?.decreasePeoeple(from: type)
            }
        }
        
        searchManager?.bindAuldtCount().sink { [weak self] (adultCount) in
            self?.adultCountLabel.text = "\(adultCount)"
        }.store(in: &cancellable)
        
        searchManager?.bindKidCount().sink { [weak self] kidCount in
            self?.kidCountLabel.text = "\(kidCount)"
        }.store(in: &cancellable)
        
        searchManager?.bindBabyCount().sink { [weak self] babyCount in
            self?.babyCountLabel.text = "\(babyCount)"
        }.store(in: &cancellable)
        
        searchManager?.bindMinusButtonisEnanbled().sink { [weak self] in
            self?.buttonsViewModel.canMinusButtonTouched(adult: $0, kid: $1, baby: $2)
        }.store(in: &cancellable)
        
        searchManager?.bindPlusButtonisEnanbled().sink { [weak self] in
            self?.buttonsViewModel.canPlusButtonTouched(adult: $0, kid: $1, baby: $2)
        }.store(in: &cancellable)
        
        nextViewControllerSubject.sink { (_) in
            let searchResultController = UIStoryboard.create(identifier: SearchResultViewController.self, name: "SearchResult")
            self.navigationController?.pushViewController(searchResultController, animated: true)
        }.store(in: &cancellable)
    }
    
}
