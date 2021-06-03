//
//  SearchResultDataSource.swift
//  airBnb
//
//  Created by HOONHA CHOI on 2021/06/03.
//

import UIKit

final class SearchResultDataSource: NSObject, UICollectionViewDataSource {
    
    private var rooms: [Room]
    
    override init() {
        self.rooms = []
    }
    
    func updateRooms(to rooms: [Room]) {
        self.rooms = rooms
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
        cell.configure(from: rooms[indexPath.row])
        return cell
    }
    
}
