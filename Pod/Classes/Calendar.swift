//
//  Calendar.swift
//  Calendar
//
//  Created by Jon Andersen on 1/19/16.
//  Copyright © 2016 Andersen. All rights reserved.
//

import Foundation


public protocol CalendarDataSource : class{
    func calendarBuildCell(cell: CalendarDateCell, calendarDate: CalendarDate)
    func calendarDidSelectCell(cell: CalendarDateCell, calendarDate: CalendarDate)
}

public protocol CalendarDelegate : class{
    func calendarExpand()
    func calendarContract()
    
}


public class Calendar: UIView {
    
    
    public let calendarCollectionView: UICollectionView!
    
    private  var calendarManager: CalendarManager!
    
    public weak var delegate: CalendarDelegate? {
        didSet{
            calendarManager.delegate = delegate
        }
    }
    public weak var dataSource: CalendarDataSource? {
        didSet {
            calendarManager.dataSource = dataSource
        }
    }
    
    public func reloadData() {
        calendarCollectionView.reloadData()
    }
    
    public required override init(frame: CGRect) {
        calendarCollectionView = UICollectionView(frame: frame, collectionViewLayout:  CalendarLayout())
        
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        calendarCollectionView = UICollectionView(frame: CGRectZero, collectionViewLayout:  CalendarLayout())
        super.init(coder: aDecoder)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        self.calendarCollectionView.frame = self.frame
    }
    
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        self.addSubview(calendarCollectionView)
        calendarCollectionView.backgroundColor = self.backgroundColor
        calendarCollectionView.showsHorizontalScrollIndicator = false
        calendarCollectionView.showsVerticalScrollIndicator = false
        
        let calendarDataSource = CalendarDataSourceManager(today: NSDate())
        
        let calendarFrameworkBundle = NSBundle(forClass: Calendar.self)
        let bundlePath = calendarFrameworkBundle.pathForResource("Calendar", ofType: "bundle")!
        let calendarResourceBundle = NSBundle(path: bundlePath)!
        
        
        
        self.calendarCollectionView.registerNib(UINib(nibName: "CalendarDateCell", bundle: calendarResourceBundle), forCellWithReuseIdentifier: CalendarDateCell.identifier)
        self.calendarCollectionView.registerNib(UINib(nibName: "CalendarMonthHeader", bundle: calendarResourceBundle), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: CalendarMonthHeader.identifer)
        if let layout = self.calendarCollectionView.collectionViewLayout as? CalendarLayout {
            layout.headerReferenceSize = CGSizeMake(self.frame.width, CalendarMonthHeader.height)
        }
        
        calendarManager = CalendarManager(collectionView: self.calendarCollectionView, calendarDataSource: calendarDataSource)
        
    }
    
    
    public func scrollToDate(calendarDate: CalendarDate) {
        self.calendarManager.scrollToDate(calendarDate)
    }
    
    
    public func scrollToDate() {
        self.calendarManager.scrollToDate(CalendarDate.fromDate(NSDate(), calendar: NSCalendar.currentCalendar()))
    }
    
}