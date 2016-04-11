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

    @IBAction func minimizePressed(sender: UIBarButtonItem) {
        calendarView.showYearView()
    }
    @IBAction func expandPressed(sender: UIBarButtonItem) {
        calendarView.showMonthView()

    }

    
    func calendarBuildCell(cell: CalendarDateCell, calendarDate: CalendarDate) {
        
    }
    func calendarDidSelectCell(cell: CalendarDateCell, calendarDate: CalendarDate) {
        
    }


}

