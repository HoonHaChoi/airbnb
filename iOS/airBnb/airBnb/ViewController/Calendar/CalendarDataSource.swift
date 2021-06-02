//
//  CalendarDataSource.swift
//  airBnb
//
//  Created by HOONHA CHOI on 2021/05/22.
//

import UIKit

class CalendarDataSource: NSObject, UICollectionViewDataSource {
    
    private let dates: [String:[Date?]]
    private var sequenceDates: SequenceDates
    
    init(dates: [String:[Date?]], sequenceDates: SequenceDates?) {
        self.dates = dates
        self.sequenceDates = sequenceDates ?? .init()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dates.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let datesSection = CalendarHelper.month(index: section)
        return dates[datesSection]?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CalendarDayCell.identifier, for: indexPath) as? CalendarDayCell else {
            return .init()
        }
        let month = CalendarHelper.month(index: indexPath.section)
        let day = dates[month]?[indexPath.row]
        cell.configure(day: day)
        cell.setupDaysRange(dates : sequenceDates, day: day)
        cell.selectDay(dates: sequenceDates, day: day)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let headerview = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CalendarHeaderView.reuseidentifier, for: indexPath) as? CalendarHeaderView else {
            return .init()
        }
        let month = CalendarHelper.month(index: indexPath.section)
        headerview.updateLabel(text: month)
        return headerview
    }
    
    func resetSelectDates() {
        sequenceDates.reset()
    }
    
    func updateSelectedDate(from dates: SequenceDates) {
        self.sequenceDates = dates
    }
}
