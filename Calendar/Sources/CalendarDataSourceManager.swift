import Foundation

class CalendarDataSourceManager {
    private let startDate = NSDate(timeIntervalSince1970: 0)
    private let calendar = NSCalendar.currentCalendar()
    private let dateManager: DateManager = DateManager()

    private func calendarDateComponents(date: NSDate) -> NSDateComponents {
        return calendar.components([.Day, .Month, .Year], fromDate: date)
    }


    func numberOfMonths() -> Int {
        let months = NSDate().monthsFrom(startDate)
        return months + 2
    }

    func currentDateIndex() -> NSIndexPath {
        let currentMonth  = self.numberOfMonths() - 2
        let todayComponenets = calendar.components(.Day, fromDate: NSDate())
        let startIndexAdd = (0...15)
            .map { self.calendarDateForMonth(currentMonth - 1, dayIndex: $0) }
            .filter { $0.isFromAnotherMonth }.count
        return NSIndexPath(forItem: startIndexAdd + todayComponenets.day - 1, inSection: currentMonth - 1)
    }

    func indexForDate(date: CalendarDate) -> NSIndexPath {
        let firstDayInMonth = dateForFirstDayInMonth(self.numberOfMonths() - 1)
        let monthDifference = 12 * (firstDayInMonth.year - date.year) + (firstDayInMonth.month - date.month)
        let month  = self.numberOfMonths() - monthDifference - 1
        let startIndexAdd = (0...15)
            .map { self.calendarDateForMonth(month, dayIndex: $0) }
            .filter { $0.isFromAnotherMonth }.count
        return NSIndexPath(forItem: startIndexAdd + date.day - 1, inSection: month)
    }

    func numberOfWeeksInMonth(month: Int) -> Int {
        return dateManager.numberOfWeeksInMonth(dateForFirstDayInMonth(month))
    }

    func calendarDateForMonth(monthIndex: Int, dayIndex: Int) -> CalendarDate {
        let firstDayInMonth = dateForFirstDayInMonth(monthIndex)
        let weekday = self.calendar.components([.Weekday], fromDate: firstDayInMonth.date).weekday
        let indexDateComponents = NSDateComponents()
        indexDateComponents.day = dayIndex - (weekday - 1)
        let indexDate = calendar.dateByAddingComponents(indexDateComponents, toDate: firstDayInMonth.date, options: [])!
        let firstDayOfMonth = dateForFirstDayInMonth(monthIndex)
        let components = calendar.components([.Year, .Month], fromDate: indexDate)
        let isFromThisMonth = firstDayOfMonth.month == components.month && firstDayOfMonth.year == components.year
        let calendarDate = CalendarDate.fromDate(indexDate, isFromAnotherMonth: !isFromThisMonth)
        return calendarDate
    }

    private func dateForFirstDayInMonth(month: Int) -> CalendarDate {
        let components = NSDateComponents()
        components.month = month
        let date  = calendar.dateByAddingComponents(components, toDate: self.startDate, options: [])!
        let firstDateComponenets = calendar.components([.Year, .Month, .Day], fromDate: date)
        firstDateComponenets.day = 1
        let firstDate = calendar.dateFromComponents(firstDateComponenets)!
        return  CalendarDate.fromDate(firstDate)
    }
}
