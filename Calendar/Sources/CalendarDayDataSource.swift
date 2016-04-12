//
//  CalendarManager.swift
//  Calendar
//
//  Created by Jon Andersen on 1/16/16.
//  Copyright © 2016 Andersen. All rights reserved.
//

import Foundation



class CalendarDayDataSource: NSObject, UICollectionViewDataSource {
    private let calendarDataSource: CalendarDataSourceManager
    private var loadingMore = false
    private let numberOfItemsPerRow: CGFloat = 7
    private let dateFormatter = NSDateFormatter()

    weak var delegate: CalendarDelegate?

    required init(calendarDataSource: CalendarDataSourceManager) {
        self.calendarDataSource = calendarDataSource
        super.init()
        dateFormatter.dateFormat = "EEE, MM d"
    }

    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String,
        atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryViewOfKind(
            kind,
            withReuseIdentifier: CalendarDayHeader.reuseIdentifier,
            forIndexPath: indexPath) as! CalendarDayHeader
        let calendarDate = calendarDataSource.calendarDateForMonth(indexPath.section, dayIndex: 12)
        let hidden = (0...6)
            .map { self.calendarDataSource.calendarDateForMonth(indexPath.section, dayIndex: $0) }
            .filter { $0.isFromAnotherMonth }
        let padding: CGFloat = CGFloat(hidden.count) * ((collectionView.frame.width / numberOfItemsPerRow) + 4)
        header.monthLabel.text = "\(dateFormatter.shortMonthSymbols[calendarDate.month - 1])"
        header.leadingConstraint.constant = max(padding, 8.0)
        if calendarDate.isThisMonth() {
            header.monthLabel.textColor = Colors.headerCurrentTextColor
        } else {
            header.monthLabel.textColor = Colors.headerTextColor
        }
        return header
    }
    
    func indexForDate(calendarDate: CalendarDate) -> NSIndexPath {
        return calendarDataSource.indexForDate(calendarDate)
    }

    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return calendarDataSource.numberOfMonths()
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7 * calendarDataSource.numberOfWeeksInMonth(section)
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(
            CalendarDateCell.identifier, forIndexPath: indexPath) as! CalendarDateCell
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        let calendarDate = calendarDataSource.calendarDateForMonth(indexPath.section, dayIndex: indexPath.item)
        cell.textLabel.text = "\(calendarDate.day)"
        if calendarDate.isFromAnotherMonth {
            cell.hidden = true
        } else {
            cell.hidden = false
        }
        cell.calendarDate = calendarDate
        delegate?.calendarBuildCell(cell, calendarDate: calendarDate)
        cell.accessibilityIdentifier = calendarDate.identifier()
        CATransaction.commit()
        return cell
    }
    
    //STYLING

    func collectionView(collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let isLandscape = UIDevice.currentDevice().orientation.isLandscape.boolValue
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
            let size: CGFloat
            if isLandscape {
                size = collectionView.frame.width / (numberOfItemsPerRow + 3.0)
            } else {
                size = collectionView.frame.width / (numberOfItemsPerRow + 2.0)
            }
            return CGSize(width: size, height: size)
        } else {
            let size = collectionView.frame.width / numberOfItemsPerRow
            return CGSize(width: size, height: size)
        }
    }

    func collectionView(collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

    func collectionView(collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }

    func collectionView(collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
}
