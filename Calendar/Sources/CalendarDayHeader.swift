//
//  CalendarMonthHeader.swift
//  leapsecond
//
//  Created by Jon Andersen on 1/15/16.
//  Copyright © 2016 Andersen. All rights reserved.
//

import UIKit

class CalendarDayHeader: UICollectionReusableView {
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    static let reuseIdentifier: String = "CalendarDayHeader"
    static let height: CGFloat = 40.0
}
