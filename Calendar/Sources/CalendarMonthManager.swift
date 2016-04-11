//
//  CalendarMonthDatasource.swift
//  Calendar
//
//  Created by Jon Andersen on 4/10/16.
//  Copyright © 2016 Andersen. All rights reserved.
//

import Foundation


class CalendarMonthManager: NSObject, UICollectionViewDelegate, UICollectionViewDataSource {
    private let collectionView: UICollectionView
    private let startDate = NSDate(timeIntervalSince1970: 0)
    private let dateFormatter = NSDateFormatter()

    
    
    required init(collectionView: UICollectionView) {
        self.collectionView = collectionView
        super.init()
        collectionView.dataSource = self
        collectionView.delegate = self
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
        let month = indexPath.item
        let year = indexPath.section
        
        let components = NSDateComponents()
        components.year = year
        components.month = month
        
        let date = NSCalendar.currentCalendar().dateByAddingComponents(components, toDate: self.startDate, options: [])!
        let calendarDate = CalendarDate.fromDate(date)
        
        header.monthLabel.textColor = UIColor.blackColor()
        header.monthLabel.text = "\(calendarDate.year)"
        header.leadingConstraint.constant = 8.0
        return header
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
        let month = indexPath.item
        let year = indexPath.section
        
        let components = NSDateComponents()
        components.year = year
        components.month = month
        
        let date = NSCalendar.currentCalendar().dateByAddingComponents(components, toDate: self.startDate, options: [])!
        let calendarDate = CalendarDate.fromDate(date)
        
        cell.label.text = "\(dateFormatter.shortMonthSymbols[calendarDate.month - 1])"
        
        return cell
    }

    
    //STYLING
    
    func collectionView(collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let isLandscape = UIDevice.currentDevice().orientation.isLandscape.boolValue
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
            let size: CGFloat
            if isLandscape {
                size = collectionView.frame.width / (4)
            } else {
                size = collectionView.frame.width / (3)
            }
            return CGSize(width: size, height: size)
        } else {
            let size = collectionView.frame.width / 3
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