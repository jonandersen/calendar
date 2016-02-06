//
//  CalendarDataSourceTests.swift
//  leapsecond
//
//  Created by Jon Andersen on 1/3/16.
//  Copyright © 2016 Andersen. All rights reserved.
//

import XCTest
import Calendar
import Nimble

@testable import Calendar

class CalendarDataSourceTests: XCTestCase {
    
    private var sut: CalendarDataSource!
    let calendarDate = CalendarDate(year: 2016, month: 1, day: 15)
    
    
    //Notes for below
    //Month 0: -> Feburary 2016
    //Month 1: -> January 2016
    //Month 2: -> December 2015
    
    override func setUp() {
        super.setUp()
        
        sut = CalendarDataSource(batchSize: 30, today: calendarDate.date(NSCalendar.currentCalendar()))
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    
    
    func testDatesWithLargeBatchSize() {
        expect(self.sut.fromDate).to(equal(CalendarDate(year: 2015, month: 12, day: 15)))
        expect(self.sut.toDate).to(equal(CalendarDate(year: 2016, month: 2, day: 15)))
    }
    
    
    func testNumberOfMonths() {
        expect(self.sut.numberOfMonths()).to(equal(3))
    }
    
    func testNumberOfWeeks() {
        expect(self.sut.numberOfWeeksInMonth(1)).to(equal(6))
    }
    
//    func testGetDateMonth() {
//        let month = self.sut.calendarDateForMonth(Int, dayIndex: <#T##Int#>)
//        expect(month.month).to(equal(12))
//        expect(month.year).to(equal(2015))
//        expect(month.day).to(equal(15))
//        expect(self.sut.calendarDateForMonth(1).month).to(equal(1))
//        expect(self.sut.calendarDateForMonth(2).month).to(equal(2))
//    }
    
    func testGetFirstDate() {
        let date = self.sut.calendarDateForMonth(0, dayIndex: 0)
        expect(date.day).to(equal(29))
        expect(date.month).to(equal(11))
        expect(date.year).to(equal(2015))
    }
    
    func testGetFirstDateOfMonth() {
        let date = self.sut.calendarDateForMonth(1, dayIndex: 0)
        expect(date.day).to(equal(27))
        expect(date.month).to(equal(12))
        expect(date.year).to(equal(2015))
    }
    
    func testGetLastDateOfMonth() {
        let date = self.sut.calendarDateForMonth(1, dayIndex: 41)
        expect(date.day).to(equal(6))
        expect(date.month).to(equal(2))
        expect(date.year).to(equal(2016))
    }
    
    
    func testIndexIsInMonth() {
        expect(self.sut.indexIsInMonth(0, month: 1)).to(equal(false)) //0 -> 2015-27-12
        expect(self.sut.indexIsInMonth(5, month: 1)).to(equal(true)) //5 -> 2016-01-01
        
        
    }
    
}
