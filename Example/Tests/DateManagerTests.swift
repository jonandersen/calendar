//
//  CalendarDateManagerTests.swift
//  leapsecond
//
//  Created by Jon Andersen on 1/15/16.
//  Copyright © 2016 Andersen. All rights reserved.
//

import XCTest
import Calendar
import Nimble

@testable import Calendar
class DateManagerTests: XCTestCase {
    private var sut: DateManager!
    
    override func setUp() {
        super.setUp()
        sut = DateManager()
    }
    

    func testNumberOfWeeksInMonthSundayFirstDayOfWeek() {
        expect(self.sut.numberOfWeeksInMonth(CalendarDate(year: 2015, month: 12, day: 1))).to(equal(5))
        
        expect(self.sut.numberOfWeeksInMonth(CalendarDate(year: 2016, month: 1, day: 1))).to(equal(6))
        expect(self.sut.numberOfWeeksInMonth(CalendarDate(year: 2016, month: 2, day: 1))).to(equal(5))
        
    }
    
    
    
}
