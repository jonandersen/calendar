//
//  CalendarMonthDatasource.swift
//  Calendar
//
//  Created by Jon Andersen on 4/10/16.
//  Copyright © 2016 Andersen. All rights reserved.
//

import Foundation


class CalendarMonthDataSource: NSObject, UICollectionViewDataSource {
    private let startDate = NSDate(timeIntervalSince1970: 0)
    private let dateFormatter = NSDateFormatter()

    required override init() {
        super.init()
        dateFormatter.dateFormat = "EEE, MM d"
    }

    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String,
                        atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryViewOfKind(
            kind,
            withReuseIdentifier: CalendarMonthHeader.reuseIdentifier,
            forIndexPath: indexPath) as! CalendarMonthHeader
        let calendarDate = calendarDateForIndexPath(indexPath)
        header.yearLabel.text = "\(calendarDate.year)"
        if calendarDate.isThisYear() {
            header.yearLabel.textColor = Colors.headerCurrentTextColor
        } else {
            header.yearLabel.textColor = Colors.headerTextColor
        }
        return header
    }

    func indexForDate(calendarDate: CalendarDate) -> NSIndexPath {
        let year = abs(calendarDate.date.yearsFrom(startDate))
        return NSIndexPath(forItem: 6, inSection: year)
    }

    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        let months = NSDate().monthsFrom(startDate)
        return Int(ceil(Double(months) / 12))
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(CalendarMonthCell.reuseIdentifier, forIndexPath: indexPath) as! CalendarMonthCell
        let calendarDate = calendarDateForIndexPath(indexPath)
        cell.label.text = "\(dateFormatter.shortMonthSymbols[calendarDate.month - 1])"
        cell.calendarDate = calendarDate
        return cell
    }

    private func calendarDateForIndexPath(indexPath: NSIndexPath) -> CalendarDate {
        let month = indexPath.item
        let year = indexPath.section
        let components = NSDateComponents()
        components.year = year
        components.month = month + 1
        let date = NSCalendar.currentCalendar().dateByAddingComponents(components, toDate: self.startDate, options: [])!
        return CalendarDate.fromDate(date)
    }
}
