import UIKit

class CalendarMonthHeader: UICollectionReusableView {
    @IBOutlet weak var yearLabel: UILabel!
    static let reuseIdentifier: String = "CalendarMonthHeader"
    static let height: CGFloat = 44.0
}
