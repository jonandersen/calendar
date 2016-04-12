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

    func numberOfWeeksInMonth(calendarDate: CalendarDate) -> Int {
        let firstDayOfMonthComponents = calendar.components([.Year, .Month], fromDate: calendarDate.date)
        guard let firstDayOfMonth = calendar.dateFromComponents(firstDayOfMonthComponents) else {
            return 0
        }

        let lastDayInMonthComponents = NSDateComponents()
        lastDayInMonthComponents.month = 1
        lastDayInMonthComponents.day = -1
        guard let lastDayInMonth = calendar.dateByAddingComponents(lastDayInMonthComponents, toDate: firstDayOfMonth, options: []) else {
            return 0
        }

        let fromWeekdayComponent = calendar.components([.WeekOfYear, .YearForWeekOfYear], fromDate: firstDayOfMonth)
        fromWeekdayComponent.weekday = firstDayOfWeek
        guard let fromWeekday = calendar.dateFromComponents(fromWeekdayComponent) else {
            return 0
        }
        let toWeekdayComponent = calendar.components([.WeekOfYear, .YearForWeekOfYear], fromDate: lastDayInMonth)
        toWeekdayComponent.weekday = firstDayOfWeek
        guard let toWeekday = calendar.dateFromComponents(toWeekdayComponent) else {
            return 0
        }
        return 1 + calendar.components([.WeekOfYear], fromDate: fromWeekday, toDate: toWeekday, options: []).weekOfYear
    }
}

extension NSDate {
    func yearsFrom(date: NSDate) -> Int {
        return NSCalendar.currentCalendar().components(.Year, fromDate: date, toDate: self, options: []).year
    }
    func monthsFrom(date: NSDate) -> Int {
        return NSCalendar.currentCalendar().components(.Month, fromDate: date, toDate: self, options: []).month
    }
    func weeksFrom(date: NSDate) -> Int {
        return NSCalendar.currentCalendar().components(.WeekOfYear, fromDate: date, toDate: self, options: []).weekOfYear
    }
    func daysFrom(date: NSDate) -> Int {
        return NSCalendar.currentCalendar().components(.Day, fromDate: date, toDate: self, options: []).day
    }
}
