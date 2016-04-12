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
    func calendarDidSelectDayCell(cell: CalendarDateCell, calendarDate: CalendarDate)
    func calendarDidSelectMonthCell(cell: CalendarMonthCell, calendarDate: CalendarDate)

}

enum CalendarMode {
    case Month
    case Day
}

public class Calendar: UIView {
    public let calendarCollectionView: UICollectionView!
    private let calendarMonthCollectionView: UICollectionView!
    private var currentMode = CalendarMode.Day

    private  var calendarDayDataSource: CalendarDayDataSource!
    private  var calendarMonthDataSource: CalendarMonthDataSource!
    private  var calendarDayDelegate: CalendarCollectionViewDelegate!
    private  var calendarMonthDelegate: CalendarCollectionViewDelegate!


    public weak var delegate: CalendarDelegate? {
        didSet {
            calendarDayDataSource.delegate = delegate
            calendarDayDelegate.delegate = delegate
            calendarMonthDelegate.delegate = delegate
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
        currentMode = .Month
        self.calendarMonthCollectionView.hidden = false
        UIView.animateWithDuration(0.3, animations: {
            self.calendarCollectionView.alpha = 0.0
            self.calendarMonthCollectionView.alpha = 1.0
        }) { _ in
            self.calendarCollectionView.hidden = true
        }
    }

    public func showMonthView() {
        currentMode = .Day
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
        calendarCollectionView.contentInset = UIEdgeInsetsZero

        calendarCollectionView.backgroundColor = self.backgroundColor
        calendarMonthCollectionView.backgroundColor = self.backgroundColor

        calendarCollectionView.showsHorizontalScrollIndicator = false
        calendarCollectionView.showsVerticalScrollIndicator = false
        let calendarDataSource = CalendarDataSourceManager()
        let calendarFrameworkBundle = NSBundle(forClass: Calendar.self)
        let calendarResourceBundle: NSBundle
        if let bundlePath = calendarFrameworkBundle.pathForResource("Calendar", ofType: "bundle") {
            calendarResourceBundle = NSBundle(path: bundlePath) ?? calendarFrameworkBundle
        } else {
            calendarResourceBundle = calendarFrameworkBundle
        }
        self.configureDayCollectionView(calendarResourceBundle)
        self.configuredMonthCollectionView(calendarResourceBundle)

        calendarDayDataSource = CalendarDayDataSource(calendarDataSource: calendarDataSource)
        calendarMonthDataSource = CalendarMonthDataSource()
        calendarDayDelegate = CalendarCollectionViewDelegate(itemsPerRow: 7)
        calendarMonthDelegate = CalendarCollectionViewDelegate(itemsPerRow: 3)
        self.calendarCollectionView.dataSource = calendarDayDataSource
        self.calendarCollectionView.delegate = calendarDayDelegate
        self.calendarMonthCollectionView.dataSource = calendarMonthDataSource
        self.calendarMonthCollectionView.delegate = calendarMonthDelegate
    }

    public func scrollToDate(calendarDate: CalendarDate) {
        switch currentMode {
        case .Day:
            let index = self.calendarDayDataSource.indexForDate(calendarDate)
            calendarCollectionView.scrollToItemAtIndexPath(index, atScrollPosition: .CenteredVertically, animated: false)
        case .Month:
            let index = self.calendarMonthDataSource.indexForDate(calendarDate)
            calendarMonthCollectionView.scrollToItemAtIndexPath(index, atScrollPosition: .CenteredVertically, animated: false)
        }

    }

    public func scrollToDate() {
        let calendarDate = CalendarDate.fromDate(NSDate())
        self.scrollToDate(calendarDate)
    }

    private func configureDayCollectionView(bundle: NSBundle) {
        let cellNib = UINib(nibName: "CalendarDateCell", bundle: bundle)
        self.calendarCollectionView.registerNib(cellNib,
                                                forCellWithReuseIdentifier: CalendarDateCell.identifier)
        let dayHeaderNib = UINib(nibName: CalendarDayHeader.reuseIdentifier, bundle: bundle)
        self.calendarCollectionView.registerNib(dayHeaderNib, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader,
                                                withReuseIdentifier: CalendarDayHeader.reuseIdentifier)
        if let layout = self.calendarCollectionView.collectionViewLayout as? CalendarLayout {
            layout.headerReferenceSize = CGSize(width: self.frame.width,
                                                height: CalendarDayHeader.height)
        }
    }

    private func configuredMonthCollectionView(bundle: NSBundle) {
        let monthHeaderNib = UINib(nibName: CalendarMonthHeader.reuseIdentifier, bundle: bundle)
        if let layout = self.calendarMonthCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.headerReferenceSize = CGSize(width: self.frame.width,
                                                height: CalendarMonthHeader.height)
        }
        self.calendarMonthCollectionView.registerNib(monthHeaderNib,
                                                     forSupplementaryViewOfKind: UICollectionElementKindSectionHeader,
                                                     withReuseIdentifier: CalendarMonthHeader.reuseIdentifier)
        let calendarMonthCell = UINib(nibName: "CalendarMonthCell", bundle: bundle)
        self.calendarMonthCollectionView.registerNib(calendarMonthCell,
                                                     forCellWithReuseIdentifier: CalendarMonthCell.reuseIdentifier)
    }
}
