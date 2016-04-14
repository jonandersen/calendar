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
    private weak var collectionView: UICollectionView?
    weak var delegate: CalendarDelegate?

    init(collectionView: UICollectionView, itemsPerRow: Int) {
        self.itemsPerRow = CGFloat(itemsPerRow)
        self.collectionView = collectionView
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
    
    private var startScroll: CGFloat = 0.0
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        startScroll = scrollView.contentOffset.y
    }
   
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        startScroll = 0.0
        scrollPositionChanged()
    }
    
    func scrollViewWillBeginDecelerating(scrollView: UIScrollView) {
        scrollPositionChanged()
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        guard abs(Double(scrollView.contentOffset.y - startScroll)) > 10.0 else{
            return
        }
        startScroll = scrollView.contentOffset.y
//        scrollPositionChanged()
    }
    
    private func scrollPositionChanged() {
        if let collectionView = self.collectionView {
            var visibleRect = CGRect()
            visibleRect.origin = collectionView.contentOffset
            visibleRect.size = collectionView.bounds.size
            
            let visiblePoint = CGPointMake(CGRectGetMidX(visibleRect), CGRectGetMaxY(visibleRect))
            
            let indexPath: NSIndexPath
            if let ip = collectionView.indexPathForItemAtPoint(visiblePoint) {
                indexPath = ip
            } else{
                let cells = collectionView.visibleCells()
                indexPath = collectionView.indexPathForCell(cells[0] as! UICollectionViewCell)! as NSIndexPath
            }
            

            
            if let cell = collectionView.cellForItemAtIndexPath(indexPath) as? CalendarDateCell {
                delegate?.calendarDateChanged(cell.calendarDate)
            } else if let cell = collectionView.cellForItemAtIndexPath(indexPath) as? CalendarMonthCell {
                delegate?.calendarDateChanged(cell.calendarDate)
            }
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
