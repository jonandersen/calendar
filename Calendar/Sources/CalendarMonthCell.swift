//
//  CalendarMonthCell.swift
//  Calendar
//
//  Created by Jon Andersen on 4/10/16.
//  Copyright © 2016 Andersen. All rights reserved.
//

import Foundation
import UIKit

class CalendarMonthCell: UICollectionViewCell {
    
    static let reuseIdentifier: String = "CalendarMonthCell"
    
    @IBOutlet weak var label: UILabel!
    
    public override func awakeFromNib() {
        self.layer.borderColor = UIColor(red: 0x33/256, green: 0xB3/256, blue: 0xB3/256, alpha: 0.5).CGColor
        self.layer.borderWidth = 1.0
        self.layer.cornerRadius = 4.0
    }
    
    
}