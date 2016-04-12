//
//  CalendarCollectionViewDelegate.swift
//  Calendar
//
//  Created by Jon Andersen on 4/11/16.
//  Copyright © 2016 Andersen. All rights reserved.
//

import UIKit

class CalendarCollectionViewDelegate: NSObject, UICollectionViewDelegate {
    private let itemsPerRow: CGFloat
    weak var delegate: CalendarDelegate?
    
    init(itemsPerRow: Int) {
        self.itemsPerRow = CGFloat(itemsPerRow)
        super.init()
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if let cell = collectionView.cellForItemAtIndexPath(indexPath) as? CalendarDateCell {
            delegate?.calendarDidSelectDayCell(cell, calendarDate: cell.calendarDate)
        } else if let cell = collectionView.cellForItemAtIndexPath(indexPath) as? CalendarMonthCell {
            delegate?.calendarDidSelectMonthCell(cell, calendarDate: cell.calendarDate)
        }
    }

    
    
    func collectionView(collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let isLandscape = UIDevice.currentDevice().orientation.isLandscape.boolValue
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
            let size: CGFloat
            if isLandscape {
                size = collectionView.frame.width / (itemsPerRow + 1)
            } else {
                size = collectionView.frame.width / (itemsPerRow)
            }
            return CGSize(width: size, height: size)
        } else {
            let size = collectionView.frame.width / itemsPerRow
            return CGSize(width: size - 8, height: size - 8)
        }
    }
    
    
    func collectionView(collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 4)
    }
    
    func collectionView(collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 4
    }
    
    func collectionView(collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 4
    }
}
