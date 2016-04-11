//
//  CalendarManager.swift
//  Calendar
//
//  Created by Jon Andersen on 1/16/16.
//  Copyright © 2016 Andersen. All rights reserved.
//

import Foundation



class CalendarManager: NSObject, UICollectionViewDelegate, UICollectionViewDataSource {
    private let calendarDataSource: CalendarDataSourceManager
    private var loadingMore = false
    private let numberOfItemsPerRow: CGFloat = 7
    private let collectionView: UICollectionView
    private let dateFormatter = NSDateFormatter()

    weak var delegate: CalendarDelegate?

    required init(collectionView: UICollectionView, calendarDataSource: CalendarDataSourceManager) {
        self.calendarDataSource = calendarDataSource
        self.collectionView = collectionView
        super.init()
        dateFormatter.dateFormat = "EEE, MM d"
        collectionView.dataSource = self
        collectionView.delegate = self
    }

    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String,
        atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryViewOfKind(
            kind,
            withReuseIdentifier: CalendarHeader.reuseIdentifier,
            forIndexPath: indexPath) as! CalendarHeader
        let calendarDate = calendarDataSource.calendarDateForMonth(indexPath.section, dayIndex: 12)
        let hidden = (0...6)
            .map { self.calendarDataSource.calendarDateForMonth(indexPath.section, dayIndex: $0) }
            .filter { $0.isFromAnotherMonth }
        let padding: CGFloat = CGFloat(hidden.count) * (collectionView.frame.width / numberOfItemsPerRow)
        header.monthLabel.text = "\(dateFormatter.shortMonthSymbols[calendarDate.month - 1]) \(calendarDate.year)"
        header.monthLabel.textColor = UIColor.blackColor()
        header.leadingConstraint.constant = padding
        return header
    }

    func scrollToDate(calendarDate: CalendarDate) {
        let index = calendarDataSource.indexForDate(calendarDate)
        collectionView.scrollToItemAtIndexPath(index, atScrollPosition: .CenteredVertically, animated: false)
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
        delegate?.calendarBuildCell(cell, calendarDate: calendarDate)
        cell.accessibilityIdentifier = calendarDate.identifier()
        CATransaction.commit()
        return cell
    }

    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if let cell = collectionView.cellForItemAtIndexPath(indexPath) as? CalendarDateCell {
            let calendarDate = calendarDataSource.calendarDateForMonth(indexPath.section, dayIndex: indexPath.item)
            delegate?.calendarDidSelectCell(cell, calendarDate: calendarDate)
        }
    }

    //MARK : SCROLL
//
//    func scrollViewDidScroll(scrollView: UIScrollView) {
//        if loadingMore || scrollView.contentOffset.y >= 0 {
//            return
//        }
//        self.loadingMore = true
//        let newMonths = self.calendarDataSource.loadMoreDates()
//        if newMonths == 0 {
//            return
//        }
//        CATransaction.begin()
//        CATransaction.setDisableActions(true)
//        let layout = collectionView.collectionViewLayout as! CalendarLayout
//        layout.isInsertingCellsToTop = true
//        layout.contentSizeWhenInsertingToTop = collectionView.contentSize
//        UIView.performWithoutAnimation { () -> Void in
//            UIView.setAnimationsEnabled(false)
//            self.collectionView.performBatchUpdates({ () -> Void in
//                let range = NSRange.init(location: 0, length: newMonths)
//                self.collectionView.insertSections(NSIndexSet(indexesInRange: range))
//                }) { (finished) -> Void in
//                    UIView.setAnimationsEnabled(true)
//                    CATransaction.commit()
//                    self.loadingMore = false
//            }
//        }
//    }

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
