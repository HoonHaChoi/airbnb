//
//  CalendarDataSource.swift
//  airBnb
//
//  Created by HOONHA CHOI on 2021/05/22.
//

import UIKit

class CalendarDataSource: NSObject, UICollectionViewDataSource {
    
    private let months: [String]
    private let days: [[Date?]]
    private var sequenceDates: SequenceDates
    
    init(months: [String],
        days: [[Date?]],
        sequenceDates: SequenceDates?) {
        self.months = months
        self.days = days
        self.sequenceDates = sequenceDates ?? .init()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return months.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return days[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CalendarDayCell.identifier, for: indexPath) as? CalendarDayCell else {
            return .init()
        }
    
        let day = days[indexPath.section][indexPath.row] ?? .init()
        cell.configure(day: day)
        cell.setupDaysRange(dates : sequenceDates, day: day)
        cell.selectDay(dates: sequenceDates, day: day)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let headerview = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CalendarHeaderView.reuseidentifier, for: indexPath) as? CalendarHeaderView else {
            return .init()
        }
        let monthString = months[indexPath.section]
        headerview.updateLabel(text: monthString)
        return headerview
    }
    
    func resetSelectDates() {
        sequenceDates.reset()
    }
    
    func updateSelectedDate(from dates: SequenceDates) {
        self.sequenceDates = dates
    }
}
