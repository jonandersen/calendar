
import Foundation

class CalendarDataSourceManager {
    var fromDate: CalendarDate = CalendarDate.empty()
    var toDate: CalendarDate = CalendarDate.empty()
    private let calendar = NSCalendar.currentCalendar()
    private let componentsAfter: NSDateComponents
    private let componentsBefore: NSDateComponents
    private let batchSize: Int = 12
    private let dateManager: DateManager = DateManager()
    private let currentDate: CalendarDate
    
    private func calendarDateComponents(date: NSDate) -> NSDateComponents {
        return calendar.components([.Day, .Month, .Year], fromDate: date)
    }
    
    
    
    init(today: NSDate) {
        //        self.batchSize = batchSize
        componentsAfter =  NSDateComponents()
        componentsAfter.month = 1
        
        componentsBefore =  NSDateComponents()
        componentsBefore.month = -self.batchSize
        
        currentDate = CalendarDate.fromDate(today, calendar: calendar)
        
        if let now = calendar.dateFromComponents(calendarDateComponents(today)) {
            guard let before = calendar.dateByAddingComponents(componentsBefore, toDate: now, options: []) else {
                return
            }
            guard let after = calendar.dateByAddingComponents(componentsAfter, toDate: now, options: [])  else {
                return
            }
            
            
            fromDate = CalendarDate.fromDate(before, calendar: calendar)
            toDate = CalendarDate.fromDate(after, calendar: calendar)
            
        }else{
            NSLog("ERROR can't create date from componetnes %@", calendarDateComponents(today))
        }
        
    }
    
    
    func numberOfMonths() -> Int {
        let monthDifference = self.toDate.month - self.fromDate.month + 1
        if(self.toDate.year == self.fromDate.year) {
            return monthDifference
        }else{
            let yearsDifference = self.toDate.year - self.fromDate.year
            return yearsDifference * 12 + monthDifference
        }
    }
    
    func currentDateIndex() -> NSIndexPath {
        
        let currentMonth  = self.numberOfMonths() - 1
        let todayComponenets = calendar.components(.Day, fromDate: NSDate())
        
        
        let startIndexAdd = (0...15).map{self.calendarDateForMonth(currentMonth - 1, dayIndex: $0)}
            .filter{$0.isFromAnotherMonth}.count
        
        
        return NSIndexPath(forItem: startIndexAdd + todayComponenets.day - 1, inSection: currentMonth - 1)
    }
    
    func indexForDate(date: CalendarDate) -> NSIndexPath {
        let firstDayInMonth = dateForFirstDayInMonth(self.numberOfMonths() - 1)
        let monthDifference = 12 * (firstDayInMonth.year - date.year) + (firstDayInMonth.month - date.month)
        
        let currentMonth  = monthDifference + 2
        
        
        let startIndexAdd = (0...15).map{self.calendarDateForMonth(currentMonth - 1, dayIndex: $0)}
            .filter{$0.isFromAnotherMonth}.count
        
        
        return NSIndexPath(forItem: startIndexAdd + date.day - 1, inSection: currentMonth - 1)
    }
    
    
    
    func numberOfWeeksInMonth(month: Int) -> Int {
        return dateManager.numberOfWeeksInMonth(dateForFirstDayInMonth(month))
    }
    
    
    
    func calendarDateForMonth(monthIndex: Int, dayIndex: Int) -> CalendarDate {
        let firstDayInMonth = dateForFirstDayInMonth(monthIndex)
        let weekday = self.calendar.components([.Weekday], fromDate: firstDayInMonth.date(calendar)).weekday
        
        let indexDateComponents = NSDateComponents()
        indexDateComponents.day = dayIndex - (weekday - 1)
        let indexDate = calendar.dateByAddingComponents(indexDateComponents, toDate: firstDayInMonth.date(calendar), options: [])!
        
        let firstDayOfMonth = dateForFirstDayInMonth(monthIndex)
        
        let components = calendar.components([.Year, .Month], fromDate: indexDate)
        let isFromThisMonth = firstDayOfMonth.month == components.month && firstDayOfMonth.year == components.year
        
        let calendarDate = CalendarDate.fromDate(indexDate, calendar: calendar, isFromAnotherMonth: !isFromThisMonth)
        return calendarDate
    }
    
    func loadMoreDates() -> Int{
        guard let date = calendar.dateByAddingComponents(componentsBefore, toDate: fromDate.date(calendar), options: []) else {
            NSLog("Failed to load moare")
            return 0
        }
        fromDate = CalendarDate.fromDate(date, calendar: calendar)
        return self.batchSize
    }
    
    
    private func dateFromCalendarDate(calendarDate: CalendarDate) -> NSDate {
        return calendar.dateFromComponents(calendarDate.components())! //TODO GUARD
    }
    
    private func dateForFirstDayInMonth(month: Int) -> CalendarDate {
        let components = NSDateComponents()
        components.month = month
        let date  = self.calendar.dateByAddingComponents(components, toDate: self.fromDate.date(calendar), options: [])!
        let firstDateComponenets = calendar.components([.Year, .Month, .Day], fromDate: date)
        firstDateComponenets.day = 1
        let firstDate = calendar.dateFromComponents(firstDateComponenets)!
        
        return  CalendarDate.fromDate(firstDate , calendar: calendar)
    }
    
}