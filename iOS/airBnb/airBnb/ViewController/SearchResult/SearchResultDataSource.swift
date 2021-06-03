//
//  SearchResultDataSource.swift
//  airBnb
//
//  Created by HOONHA CHOI on 2021/06/03.
//

import UIKit

final class SearchResultDataSource: NSObject, UICollectionViewDataSource {
    
    private var rooms: [Room]
    private var differenceDays: Int
    private var searchCondition: String
    
    override init() {
        self.rooms = []
        self.differenceDays = 1
        self.searchCondition = ""
    }
    
    func updateRooms(to rooms: [Room], days: Int, condition: String) {
        self.rooms = rooms
        self.differenceDays = days
        self.searchCondition = condition
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return rooms.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchResultCell.identifier, for: indexPath) as? SearchResultCell else {
            return .init()
        }
        cell.configure(from: rooms[indexPath.row], days: differenceDays)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SearchResultHeaderView.reuseidentifier, for: indexPath) as? SearchResultHeaderView else {
            return .init()
        }
        headerView.configure(from: searchCondition, count: rooms.count)
        return headerView
    }
    
}
