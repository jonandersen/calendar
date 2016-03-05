//
//  CalendarDate.swift
//  Calendar
//
//  Created by Jon Andersen on 1/10/16.
//  Copyright © 2016 Andersen. All rights reserved.
//

import Foundation

public struct CalendarDate {
    public let year: Int
    public let month: Int
    public let week: Int
    public let day: Int
    private let description: String
    private let date: NSDate
    public let components = NSDateComponents()
    
    
    public let isFromAnotherMonth: Bool
    
    private static let componentsToday = NSCalendar.currentCalendar().components([.Year, .Month, .WeekOfYear, .Day], fromDate: NSDate())
    
    public static func empty() -> CalendarDate {
        return CalendarDate(year: 0, month: 0, week: 0, day: 0, isFromAnotherMonth: false)
    }
    
    
    
    public init(year: Int, month: Int, week: Int = 0, day: Int, isFromAnotherMonth: Bool = false){
        self.year = year
        self.month = month
        self.week = week
        self.day = day
        self.isFromAnotherMonth = isFromAnotherMonth
        self.description = "\(year)-\(month)-\(day)"
        components.year = year
        components.month = month
        components.day = day
        self.date = NSCalendar.currentCalendar().dateFromComponents(components)!
    }
    
    
    public static func fromDate(date: NSDate, calendar: NSCalendar, isFromAnotherMonth: Bool = false) -> CalendarDate {
        let components = calendar.components([.Year, .Month, .WeekOfYear, .Day], fromDate: date)
        return CalendarDate(year: components.year, month: components.month, week: components.weekOfYear, day: components.day, isFromAnotherMonth: isFromAnotherMonth)
    }
    
    
    public func date(calendar: NSCalendar) -> NSDate {
        return date
    }
    
    public func identifier() -> String {
        return description
    }
    
    public func isSameYear(date: CalendarDate) -> Bool {
        return date.year == self.year
    }
    
    public func isSameMonth(date: CalendarDate) -> Bool {
        return date.month == self.month && date.year == self.year
    }
    
    public func isThisYear() -> Bool {
        return CalendarDate.componentsToday.year == self.year
    }
    
    public func isThisMonth() -> Bool {
        return CalendarDate.componentsToday.month == self.month && isThisYear()
    }
    
    public func isThisWeek() -> Bool {
        return CalendarDate.componentsToday.weekOfYear == self.week && isThisMonth()
    }
    
    public func isToday() -> Bool {
        return CalendarDate.componentsToday.day == self.day && isThisWeek()
    }
    
}

extension CalendarDate : Equatable {}
public func ==(lhs: CalendarDate, rhs: CalendarDate) -> Bool {
    return lhs.year == rhs.year && lhs.month == rhs.month && lhs.day == rhs.day
}