//
//  SearchResultViewController.swift
//  airBnb
//
//  Created by HOONHA CHOI on 2021/05/30.
//

import UIKit

class SearchResultViewController: UIViewController {

    @IBOutlet weak var searchResultCollection: UICollectionView!
    
    private lazy var backButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "뒤로", style: .done, target: self, action: #selector(resetSearchResult(_:)))
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchResultCollection.dataSource = self
        searchResultCollection.delegate = self
        searchResultCollection.register(SearchResultCell.nib, forCellWithReuseIdentifier: SearchResultCell.identifier)
        searchResultCollection.register(SearchResultHeaderView.nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SearchResultHeaderView.identifier)
        navigationItem.leftBarButtonItem = backButton
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
        navigationController?.navigationBar.isHidden = false
    }
    
    @IBAction func MoveMapButtonTouched(_ sender: Any) {
        let mapViewController = UIStoryboard.create(identifier: MapViewController.self, name: "Map")
        mapViewController.modalPresentationStyle = .fullScreen
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

extension SearchResultViewController: UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchResultCell.identifier, for: indexPath) as? SearchResultCell else {
            return .init()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 380)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SearchResultHeaderView.identifier, for: indexPath) as? SearchResultHeaderView else {
            return .init()
        }
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 108)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailViewController = UIStoryboard.create(identifier: DetailViewController.self, name: "Detail")
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
}
