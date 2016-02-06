//
//  CalendarDateCell.swift
//  leapsecond
//
//  Created by Jon Andersen on 1/10/16.
//  Copyright © 2016 Andersen. All rights reserved.
//

import Foundation

public class CalendarDateCell : UICollectionViewCell {
    
    static let identifier: String = "CalendarDateCell"
    @IBOutlet public weak var textLabel: UILabel!
    
    @IBOutlet public weak var circleView: UIView!
    @IBOutlet public  weak var imageView: UIImageView!
    
    private let circleRatio: CGFloat = 0.9
    
   
    
    public override func awakeFromNib() {
        circleView.backgroundColor = UIColor(red: 0x33/256, green: 0xB3/256, blue: 0xB3/256, alpha: 0.5)
        self.clipsToBounds = true
        imageView.clipsToBounds = true
        self.layer.shouldRasterize = true;
        self.layer.rasterizationScale = UIScreen.mainScreen().scale;
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        var sizeCircle = min(self.frame.size.width, self.frame.size.height);
        sizeCircle = sizeCircle * circleRatio;
        sizeCircle = CGFloat(roundf(Float(sizeCircle)))
        
        circleView.frame = CGRectMake(0, 0, sizeCircle, sizeCircle)
        circleView.center = CGPointMake(self.frame.size.width / 2.0, self.frame.size.height / 2.0)
        circleView.layer.cornerRadius = sizeCircle / 2.0
        
        CATransaction.begin()
        imageView.frame = self.circleView.frame
        imageView.layer.cornerRadius = self.circleView.layer.cornerRadius
        CATransaction.commit()
    }
    
 
}


