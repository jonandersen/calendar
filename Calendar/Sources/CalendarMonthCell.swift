import Foundation
import UIKit

public class CalendarMonthCell: UICollectionViewCell {
    
    static let reuseIdentifier: String = "CalendarMonthCell"
    var calendarDate: CalendarDate = CalendarDate.empty()
    
    @IBOutlet weak var label: UILabel!
    
    public override func awakeFromNib() {
        self.layer.borderColor = UIColor(red: 0x33/256, green: 0xB3/256, blue: 0xB3/256, alpha: 0.5).CGColor
        self.layer.borderWidth = 1.0
        self.layer.cornerRadius = 4.0
    }
    
    
}