//
//  ViewController2.swift
//  Traffic
//
//  Created by Anna Liu on 1/8/15.
//  Copyright (c) 2015 Anna Liu. All rights reserved.
//

import UIKit

class ViewController2: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var summary:[DayTraffic]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tableView.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return summary.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell! = tableView.dequeueReusableCellWithIdentifier("Cell") as UITableViewCell!
        
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: "Cell")
        }
        
        var day = summary[indexPath.row].date
        var dateString: String?
        if (areDatesSameDay(NSDate(), dateTwo: day)) {
            dateString = "Today"
        }
        else if (isYesterday(NSDate(), yesterday: day)) {
            dateString = "Yesterday"
        }
        else {
            dateString = stringFromDate(day)
        }
        cell.textLabel!.text = dateString
        let timePassed = summary[indexPath.row].time
        cell.detailTextLabel!.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        
        var hours: Int = timePassed/3600
        var minutes: Int = (timePassed - hours*3600)/60
        var seconds = timePassed - hours*3600 - minutes*60
        
        
        //  Format the dates
        if (hours > 0) {
            if (minutes == 0) {
                if (hours == 1) {
                    cell.detailTextLabel!.text = "\(hours) hour"
                }
                else {
                    cell.detailTextLabel!.text = "\(hours) hours"
                }
            }
            else {
                cell.detailTextLabel!.text = "\(hours) h \(minutes) min"
            }
            cell.contentView.backgroundColor = UIColor(red: 246/255.0, green: 150/255.0, blue: 121/255.0, alpha: 0.5)
        }
        else if (minutes > 0) {
            cell.detailTextLabel!.text = "\(minutes) min"
            if (minutes > 40) {
                cell.contentView.backgroundColor = UIColor(red: 253/255.0, green: 198/255.0, blue: 137/255.0, alpha: 0.5)
            }
            else if (minutes > 10) {
                cell.contentView.backgroundColor = UIColor(red: 255/255.0, green: 247/255.0, blue: 153/255.0, alpha: 0.5)
            }
            else {
                cell.contentView.backgroundColor = UIColor(red: 196/255.0, green: 237/255.0, blue: 155/255.0, alpha: 0.5)
            }
        }
        else {
            cell.detailTextLabel!.text = "< 1 min"
            cell.contentView.backgroundColor = UIColor(red: 196/255.0, green: 237/255.0, blue: 155/255.0, alpha: 0.5)
        }
        
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func stringFromDate(date:NSDate) -> NSString {
        var date_formatter = NSDateFormatter()
        date_formatter.dateStyle = NSDateFormatterStyle.MediumStyle
        var date_string = date_formatter.stringFromDate(date)
        return date_string
    }
    
    //  Modified from: https://gist.github.com/lukewakeford/4e6cda958c252017e112
    func areDatesSameDay(dateOne:NSDate, dateTwo:NSDate) -> Bool {
        var calender = NSCalendar.currentCalendar()
        let flags: NSCalendarUnit = .DayCalendarUnit | .MonthCalendarUnit | .YearCalendarUnit
        var compOne: NSDateComponents = calender.components(flags, fromDate: dateOne)
        var compTwo: NSDateComponents = calender.components(flags, fromDate: dateTwo);
        return (compOne.day == compTwo.day && compOne.month == compTwo.month && compOne.year == compTwo.year);
    }
    
    func isYesterday(today:NSDate, yesterday:NSDate) -> Bool {
        var calender = NSCalendar.currentCalendar()
        let flags: NSCalendarUnit = .DayCalendarUnit | .MonthCalendarUnit | .YearCalendarUnit
        var compOne: NSDateComponents = calender.components(flags, fromDate: today)
        var compTwo: NSDateComponents = calender.components(flags, fromDate: yesterday);
        return ((compOne.day - compTwo.day) == 1 && compOne.month == compTwo.month && compOne.year == compTwo.year);
    }
    
}
