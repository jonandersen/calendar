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
    public let components = NSDateComponents()
    public let isFromAnotherMonth: Bool
    public let date: NSDate

    private let description: String
    private let calendar = NSCalendar.currentCalendar()

    public static func empty() -> CalendarDate {
        return CalendarDate(year: 0, month: 0, week: 0, day: 0, isFromAnotherMonth: false)
    }

    public init(year: Int, month: Int, week: Int = 0, day: Int, isFromAnotherMonth: Bool = false) {
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

    public static func fromDate(date: NSDate, isFromAnotherMonth: Bool = false) -> CalendarDate {
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Year, .Month, .WeekOfYear, .Day, .Second], fromDate: date)
        return CalendarDate(
            year: components.year,
            month: components.month,
            week: components.weekOfYear,
            day: components.day,
            isFromAnotherMonth: isFromAnotherMonth)
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

    private func todayComponents() -> NSDateComponents {
        return calendar.components([.Year, .Month, .WeekOfYear, .Day], fromDate: NSDate())
    }

    public func isThisYear() -> Bool {
        return todayComponents().year == self.year
    }

    public func isThisMonth() -> Bool {
        return todayComponents().month == self.month && isThisYear()
    }

    public func isThisWeek() -> Bool {
        return todayComponents().weekOfYear == self.week && isThisMonth()
    }

    public func isToday() -> Bool {
        return todayComponents().day == self.day && isThisWeek()
    }
}

extension CalendarDate : Equatable {}
public func == (lhs: CalendarDate, rhs: CalendarDate) -> Bool {
    return lhs.year == rhs.year && lhs.month == rhs.month && lhs.day == rhs.day
}
