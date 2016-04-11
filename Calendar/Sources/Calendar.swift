//
//  Calendar.swift
//  Calendar
//
//  Created by Jon Andersen on 1/19/16.
//  Copyright © 2016 Andersen. All rights reserved.
//

import Foundation

public protocol CalendarDelegate : class {
    func calendarBuildCell(cell: CalendarDateCell, calendarDate: CalendarDate)
    func calendarDidSelectCell(cell: CalendarDateCell, calendarDate: CalendarDate)
}

//public enum CalendarMode{
//    cas
//}

public class Calendar: UIView {
    public let calendarCollectionView: UICollectionView!
    private let calendarMonthCollectionView: UICollectionView!

    private  var calendarManager: CalendarManager!
    private  var calendarMonthManager: CalendarMonthManager!

    public weak var delegate: CalendarDelegate? {
        didSet {
            calendarManager.delegate = delegate
        }
    }

    public func reloadData() {
        calendarCollectionView.reloadData()
    }

    public required override init(frame: CGRect) {
        calendarCollectionView = UICollectionView(frame: frame,
            collectionViewLayout:  CalendarLayout())
        calendarMonthCollectionView = UICollectionView(frame: frame,
                                                  collectionViewLayout:  CalendarLayout())
        super.init(frame: frame)
    }

    required public init?(coder aDecoder: NSCoder) {
        calendarCollectionView = UICollectionView(frame: .zero,
            collectionViewLayout:  CalendarLayout())
        calendarMonthCollectionView = UICollectionView(frame: .zero,
                                                       collectionViewLayout:  CalendarLayout())

        super.init(coder: aDecoder)
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        self.calendarCollectionView.frame = self.frame
        self.calendarMonthCollectionView.frame = self.frame

    }
    
    public func showYearView() {
        self.calendarMonthCollectionView.hidden = false
        UIView.animateWithDuration(0.3, animations: {
            self.calendarCollectionView.alpha = 0.0
            self.calendarMonthCollectionView.alpha = 1.0
        }) { _ in
            self.calendarCollectionView.hidden = true
        }
    }
    
    public func showMonthView() {
        self.calendarCollectionView.hidden = false
        UIView.animateWithDuration(0.3, animations: {
            self.calendarCollectionView.alpha = 1.0
            self.calendarMonthCollectionView.alpha = 0.0
        }) { _ in
            self.calendarMonthCollectionView.hidden = true
        }
    }

    public override func awakeFromNib() {
        super.awakeFromNib()
        self.calendarMonthCollectionView.alpha = 0.0
        self.calendarMonthCollectionView.hidden = true
        
        self.addSubview(calendarCollectionView)
        self.addSubview(calendarMonthCollectionView)


        calendarCollectionView.backgroundColor = self.backgroundColor
        calendarMonthCollectionView.backgroundColor = self.backgroundColor

        calendarCollectionView.showsHorizontalScrollIndicator = false
        calendarCollectionView.showsVerticalScrollIndicator = false
        let calendarDataSource = CalendarDataSourceManager()
        let calendarFrameworkBundle = NSBundle(forClass: Calendar.self)
//        let bundlePath = calendarFrameworkBundle.pathForResource("Calendar", ofType: "bundle")!
        let calendarResourceBundle = calendarFrameworkBundle//NSBundle(path: bundlePath)!

        let cellNib = UINib(nibName: "CalendarDateCell", bundle: calendarResourceBundle)
        self.calendarCollectionView.registerNib(cellNib,
            forCellWithReuseIdentifier: CalendarDateCell.identifier)

        let headerNib = UINib(nibName: CalendarHeader.reuseIdentifier, bundle: calendarResourceBundle)
        self.calendarCollectionView.registerNib(headerNib,
            forSupplementaryViewOfKind: UICollectionElementKindSectionHeader,
            withReuseIdentifier: CalendarHeader.reuseIdentifier)
        self.calendarMonthCollectionView.registerNib(headerNib,
                                                forSupplementaryViewOfKind: UICollectionElementKindSectionHeader,
                                                withReuseIdentifier: CalendarHeader.reuseIdentifier)
        if let layout = self.calendarCollectionView.collectionViewLayout as? CalendarLayout {
            layout.headerReferenceSize = CGSize(width: self.frame.width,
                height: CalendarHeader.height)
        }
        
        if let layout = self.calendarMonthCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.headerReferenceSize = CGSize(width: self.frame.width,
                                                height: CalendarHeader.height)
        }
        
        let calendarMonthCell = UINib(nibName: "CalendarMonthCell", bundle: calendarResourceBundle)
        self.calendarMonthCollectionView.registerNib(calendarMonthCell,
                                                forCellWithReuseIdentifier: CalendarMonthCell.reuseIdentifier)

        calendarManager = CalendarManager(collectionView: self.calendarCollectionView,
            calendarDataSource: calendarDataSource)
        
        calendarMonthManager = CalendarMonthManager(collectionView: self.calendarMonthCollectionView)
    }

    public func scrollToDate(calendarDate: CalendarDate) {
        self.calendarManager.scrollToDate(calendarDate)
    }

    public func scrollToDate() {
        let calendarDate = CalendarDate.fromDate(NSDate())
        self.calendarManager.scrollToDate(calendarDate)
    }
}
