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
    
    override init() {
        self.rooms = []
        self.differenceDays = 1
    }
    
    func updateRooms(to rooms: [Room], days: Int) {
        self.rooms = rooms
        self.differenceDays = days
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
    
}
