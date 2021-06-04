//
//  SearchResultViewController.swift
//  airBnb
//
//  Created by HOONHA CHOI on 2021/05/30.
//

import UIKit
import Combine

class SearchResultViewController: UIViewController {
    
    @IBOutlet weak var searchResultCollection: UICollectionView!
    
    private var searchResultViewModel = SearchResultViewModel()
    private var searchResultDataSource = SearchResultDataSource()
    private var searchManager: SearchManager?
    private var searchResultDTO: SearchResultDTO?
    private var cancellable = Set<AnyCancellable>()
    
    private lazy var backButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "뒤로",
                                     style: .done,
                                     target: self,
                                     action: #selector(resetSearchResult(_:)))
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchResultCollection()
        configureSearchResultViewModel()
        navigationItem.leftBarButtonItem = backButton
        bind()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
        navigationController?.navigationBar.isHidden = false
    }
    
    private func configureSearchResultCollection() {
        searchResultCollection.dataSource = searchResultDataSource
        searchResultCollection.delegate = self
        searchResultCollection.register(SearchResultCell.nib,
                                        forCellWithReuseIdentifier: SearchResultCell.identifier)
        searchResultCollection.register(SearchResultHeaderView.nib,
                                        forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                        withReuseIdentifier: SearchResultHeaderView.reuseidentifier)
    }
    
    private func configureSearchResultViewModel() {
        guard let manager = searchManager else {
            return
        }
        searchResultDTO = SearchResultDTO(data: manager.fetchQueryString())
        guard let dto = searchResultDTO else {
            return
        }
        searchResultViewModel.requestSearchResult(from: dto)
    }
    
    private func bind() {
        searchResultViewModel.fetchSearchResultRooms()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] rooms in
                self?.searchResultDataSource.updateRooms(to: rooms,
                                                         days: self?.searchManager?.compareSelectDate() ?? 0,
                                                         condition: self?.searchResultDTO?.showSearchCondition() ?? "")
                self?.searchResultCollection.reloadData()
            }.store(in: &cancellable)
    }
    
    func injectSearchManager(from manager: SearchManager?) {
        self.searchManager = manager
    }
    
    @IBAction func MoveMapButtonTouched(_ sender: Any) {
        let mapViewController = UIStoryboard.create(identifier: MapViewController.self, name: "Map")
        mapViewController.modalPresentationStyle = .fullScreen
        mapViewController.injectViewModel(atViewModel: searchResultViewModel)
        self.present(mapViewController, animated: true, completion: nil)
    }
    
    @objc private func resetSearchResult(_ button: UIBarButtonItem) {
        guard let viewControllerStack = self.navigationController?.viewControllers else {
            return
        }
        _ = viewControllerStack.map { [weak self] in
            if $0 is MainViewController {
                self?.navigationController?.popToViewController($0, animated: true)
            }
        }
    }
}

extension SearchResultViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 380)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 108)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let searchResultDTO = searchResultDTO else {
            return
        }
        let detailViewController = UIStoryboard.create(identifier: DetailViewController.self, name: "Detail")
        detailViewController.injectRoomInfo(at: searchResultDataSource.fetchRoomDetail(at: indexPath.row),
                                            from: searchResultDTO)
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
}
