//
//  ViewController.swift
//  Calendar
//
//  Created by Jon Andersen on 02/05/2016.
//  Copyright (c) 2016 Jon Andersen. All rights reserved.
//

import UIKit
import Calendar

class ViewController: UIViewController, CalendarDelegate {

    @IBOutlet var calendar: Calendar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calendar.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func calendarBuildCell(cell: CalendarDateCell, calendarDate: CalendarDate) {
        
    }
    
    func calendarDidSelectCell(cell: CalendarDateCell, calendarDate: CalendarDate) {
        
    }

}

