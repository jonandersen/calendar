//
//  CalendarMonthHeader.swift
//  leapsecond
//
//  Created by Jon Andersen on 1/15/16.
//  Copyright © 2016 Andersen. All rights reserved.
//

import UIKit

class CalendarHeader: UICollectionReusableView {
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    static let reuseIdentifier: String = "CalendarHeader"
    static let height: CGFloat = 34.0
}
