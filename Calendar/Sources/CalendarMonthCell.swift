import Foundation
import UIKit

public class CalendarMonthCell: UICollectionViewCell {
    static let reuseIdentifier: String = "CalendarMonthCell"
    var calendarDate: CalendarDate = CalendarDate.empty()
    @IBOutlet weak var label: UILabel!
    private let circleRatio: CGFloat = 1.0

    public override func awakeFromNib() {
        self.layer.borderColor = UIColor(red: 0x33/256, green: 0xB3/256, blue: 0xB3/256, alpha: 0.5).CGColor
        self.layer.borderWidth = 1.0
        self.layer.cornerRadius = 4.0
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        CATransaction.begin()
        var sizeCircle = min(self.frame.size.width, self.frame.size.height)
        sizeCircle = sizeCircle * circleRatio
        sizeCircle = CGFloat(roundf(Float(sizeCircle)))
        self.layer.cornerRadius = sizeCircle / 2.0
        CATransaction.commit()
    }
}
