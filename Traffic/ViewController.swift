//
//  ViewController.swift
//  Traffic
//
//  Created by Anna Liu on 1/6/15.
//  Copyright (c) 2015 Anna Liu. All rights reserved.
//



import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var resetButton: UIButton!
    
    let calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
    //var summary = [DayTraffic]()
    var today = DayTraffic()
    var speed: Double = 0
    var timePassed: Int = 0
    var locationManager = CLLocationManager()
    let conversionConstant = 2.23694
    let trafficSpeed = 15.0
    
    var summary = [DayTraffic(newDate: NSDate(timeIntervalSinceNow: -86400), newTime: 1242),
    DayTraffic(newDate: NSDate(timeIntervalSinceNow: -(2*86400)), newTime: 729),
    DayTraffic(newDate: NSDate(timeIntervalSinceNow: -(3*86400)), newTime: 2876),
    DayTraffic(newDate: NSDate(timeIntervalSinceNow: -(4*86400)), newTime: 1333),
    DayTraffic(newDate: NSDate(timeIntervalSinceNow: -(5*86400)), newTime: 4531),
    DayTraffic(newDate: NSDate(timeIntervalSinceNow: -(6*86400)), newTime: 2248),
    DayTraffic(newDate: NSDate(timeIntervalSinceNow: -(7*86400)), newTime: 997),
    DayTraffic(newDate: NSDate(timeIntervalSinceNow: -(8*86400)), newTime: 3555),
    DayTraffic(newDate: NSDate(timeIntervalSinceNow: -(9*86400)), newTime: 9532)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.startUpdatingLocation()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //CLLocationManagerDelegate
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        
        var location: CLLocation = locations[locations.count-1] as CLLocation
        
        if (!summary.isEmpty) {
            if (!areDatesSameDay(location.timestamp, dateTwo: summary[0].date)) {
                summary.insert(today, atIndex: 0)
            }
            else {
                timePassed = summary[0].time
            }
        }
        else {
            summary.insert(today, atIndex: 0)
        }
        
        self.speed = location.speed
        if (self.speed != -1.0) {
            var convertedSpeed = NSString(format: "%.2f mph", self.speed * conversionConstant)
            speedLabel.text = convertedSpeed
        }
        else {
            speedLabel.text = "0.0 mph"
        }
        
        //Add to traffic counter
        if (self.speed * conversionConstant < trafficSpeed) {
            timePassed++
            summary[0].time++
            var hours: Int = timePassed/3600
            var minutes: Int = (timePassed - hours*3600)/60
            var seconds = timePassed - hours*3600 - minutes*60
            
            
            //  Format the dates
            if (hours > 0) {
                if (minutes == 0) {
                    if (hours == 1) {
                        timeLabel.text = "\(hours) hour"
                    }
                    else {
                        timeLabel.text = "\(hours) hours"
                    }
                }
                else {
                    timeLabel.text = "\(hours) h \(minutes) min"
                }
                view.backgroundColor = UIColor(red: 246/255.0, green: 150/255.0, blue: 121/255.0, alpha: 1.0)
            }
            else if (minutes > 0) {
                timeLabel.text = "\(minutes) min"
                if (minutes > 40) {
                    view.backgroundColor = UIColor(red: 253/255.0, green: 198/255.0, blue: 137/255.0, alpha: 1.0)
                }
                else if (minutes > 10) {
                    view.backgroundColor = UIColor(red: 255/255.0, green: 247/255.0, blue: 153/255.0, alpha: 1.0)
                }
            }
            else {
                timeLabel.text = "< 1 min"
            }
        }
    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        println(error)
        timeLabel.text = "No data"
        speedLabel.text = "No data"
    }
    
    @IBAction func resetTime(sender: AnyObject) {
        timePassed = 0
        view.backgroundColor = UIColor(red: 196/255.0, green: 237/255.0, blue: 155/255.0, alpha: 1.0)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject!) {
        if (segue!.identifier == "summarySegue") {
            var svc = segue!.destinationViewController as ViewController2; //do I need to fix segue!
            svc.summary = summary
            
        }
    }
    
    
    //  Modified from: https://gist.github.com/lukewakeford/4e6cda958c252017e112
    func areDatesSameDay(dateOne:NSDate, dateTwo:NSDate) -> Bool {
        var calender = NSCalendar.currentCalendar()
        let flags: NSCalendarUnit = .DayCalendarUnit | .MonthCalendarUnit | .YearCalendarUnit
        var compOne: NSDateComponents = calender.components(flags, fromDate: dateOne)
        var compTwo: NSDateComponents = calender.components(flags, fromDate: dateTwo);
        return (compOne.day == compTwo.day && compOne.month == compTwo.month && compOne.year == compTwo.year);
    }
    
}

