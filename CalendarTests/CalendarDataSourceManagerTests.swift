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

class CalendarDataSourceManagerTests: XCTestCase {

    private var sut: CalendarDataSourceManager!
    let calendarDate = CalendarDate(year: 2016, month: 1, day: 15)

    override func setUp() {
        super.setUp()
        sut = CalendarDataSourceManager(today: calendarDate.date)
    }


    func testDatesWithLargeBatchSize() {
        expect(self.sut.fromDate).to(equal(CalendarDate(year: 2015, month: 1, day: 15)))
        expect(self.sut.toDate).to(equal(CalendarDate(year: 2016, month: 2, day: 15)))
    }

    func testNumberOfMonths() {
        expect(self.sut.numberOfMonths()).to(equal(14))
    }

    func testNumberOfWeeks() {
        expect(self.sut.numberOfWeeksInMonth(1)).to(equal(4))
    }

    func testGetFirstDate() {
        let date = self.sut.calendarDateForMonth(0, dayIndex: 0)
        expect(date.day).to(equal(28))
        expect(date.month).to(equal(12))
        expect(date.year).to(equal(2014))
    }

    func testGetFirstDateOfMonth() {
        let date = self.sut.calendarDateForMonth(1, dayIndex: 0)
        expect(date.day).to(equal(1))
        expect(date.month).to(equal(2))
        expect(date.year).to(equal(2015))
    }

    func testGetLastDateOfMonth() {
        let date = self.sut.calendarDateForMonth(1, dayIndex: 41)
        expect(date.day).to(equal(14))
        expect(date.month).to(equal(3))
        expect(date.year).to(equal(2015))
    }

}
