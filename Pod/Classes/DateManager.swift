//
//  CalendarDateManager.swift
//  leapsecond
//
//  Created by Jon Andersen on 1/15/16.
//  Copyright © 2016 Andersen. All rights reserved.
//

import Foundation

class DateManager {
    private let calendar =  NSCalendar.currentCalendar()
    private let firstDayOfWeek = 1
    
    init() {
        
    }
    
    func numberOfWeeksInMonth(calendarDate: CalendarDate) -> Int {
        let firstDayOfMonthComponents = self.calendar.components([.Year, .Month], fromDate: calendarDate.date(calendar))
        guard let firstDayOfMonth = self.calendar.dateFromComponents(firstDayOfMonthComponents) else{
            return 0
        }
        
        let lastDayInMonthComponents = NSDateComponents()
        lastDayInMonthComponents.month = 1
        lastDayInMonthComponents.day = -1
        guard let lastDayInMonth = self.calendar.dateByAddingComponents(lastDayInMonthComponents, toDate: firstDayOfMonth, options: []) else{
            return 0
        }
        
        let fromWeekdayComponent = self.calendar.components([.WeekOfYear, .YearForWeekOfYear], fromDate: firstDayOfMonth)
        fromWeekdayComponent.weekday = firstDayOfWeek
        guard let fromWeekday = self.calendar.dateFromComponents(fromWeekdayComponent) else{
            return 0
        }
        
        let toWeekdayComponent = self.calendar.components([.WeekOfYear, .YearForWeekOfYear], fromDate: lastDayInMonth)
        toWeekdayComponent.weekday = firstDayOfWeek
        guard let toWeekday = self.calendar.dateFromComponents(toWeekdayComponent) else{
            return 0
        }
        
        return 1 + self.calendar.components([.WeekOfYear], fromDate: fromWeekday, toDate: toWeekday, options: []).weekOfYear
        
    }
    
}