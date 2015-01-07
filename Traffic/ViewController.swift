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
    
    var speed: Double = 0
    var timePassed: Int = 3580
    var locationManager = CLLocationManager()
    let conversionConstant = 2.23694
    let trafficSpeed = 15.0
    
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
        
        self.speed = location.speed
        
        if (self.speed != -1.0) {
            var convertedSpeed = NSString(format: "%.2f mph", self.speed * conversionConstant)
            speedLabel.text = convertedSpeed
        }
        else {
            speedLabel.text = "0.0 mph"
        }
        
        if (self.speed * conversionConstant < trafficSpeed) {
            timePassed++
            var hours: Int = timePassed/3600
            var minutes: Int = (timePassed - hours*3600)/60
            var seconds = timePassed - hours*3600 - minutes*60
            
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
    
}

