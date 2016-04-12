//
//  ViewController.swift
//  Example
//
//  Created by Jon Andersen on 4/10/16.
//  Copyright © 2016 Andersen. All rights reserved.
//

import UIKit
import Calendar

class ViewController: UIViewController, CalendarDelegate {

    @IBOutlet weak var calendarView: Calendar!
    @IBOutlet weak var minimize: UIBarButtonItem!
    @IBOutlet weak var expandButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        calendarView.delegate = self

        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        calendarView.scrollToDate()
    }

    @IBAction func minimizePressed(sender: UIBarButtonItem) {
        calendarView.showYearView()
    }
    @IBAction func expandPressed(sender: UIBarButtonItem) {
        calendarView.showMonthView()
    }

    func calendarBuildCell(cell: CalendarDateCell, calendarDate: CalendarDate) {

    }


    func calendarDidSelectDayCell(cell: CalendarDateCell, calendarDate: CalendarDate) {
        NSLog("Selected Day: \(calendarDate.day)")

    }

    func calendarDidSelectMonthCell(cell: CalendarMonthCell, calendarDate: CalendarDate) {
        NSLog("Selected Month: \(calendarDate.month)")
        calendarView.scrollToDate()

    }


}
