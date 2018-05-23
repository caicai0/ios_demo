//
//  ViewController.swift
//  CoreMotionDemo
//
//  Created by 李玉峰 on 2018/5/23.
//  Copyright © 2018年 cai. All rights reserved.
//

import UIKit
import CoreMotion
import CoreLocation

class ViewController: UIViewController,CLLocationManagerDelegate {
    
    let manager = CMMotionManager()
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var lbl: UILabel!
    @IBOutlet weak var locationLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if manager.isAccelerometerAvailable {
            if !manager.isAccelerometerActive {
                manager.accelerometerUpdateInterval = 0.3
                manager.startAccelerometerUpdates(to:OperationQueue()) { (accelerometerData, error) in
                    if let accelerometerData = accelerometerData {
                        var str = "acceleration\n"
                        str = str+"X:\(String(describing: accelerometerData.acceleration.x))\n"
                        str = str+"Y:\(String(describing: accelerometerData.acceleration.y))\n"
                        str = str+"Z:\(String(describing: accelerometerData.acceleration.z))\n"
                        
                        let rad = atan((accelerometerData.acceleration.z)/sqrt((accelerometerData.acceleration.x)*(accelerometerData.acceleration.x)+(accelerometerData.acceleration.y)*(accelerometerData.acceleration.y)))
                        str = str + "rad:\(rad)\n"
                        let angle = rad/Double.pi*180
                        str = str + "angle:\(angle)\n"
                        str = str + "complementAngle:\(90-abs(angle))"
                        
                        DispatchQueue.main.async {
                            self.lbl.text = str
                        }
                    }
                }
            }
        }
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // CLLocationManagerDelegate verticalAccuracy
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if locations.last != nil {
            let location : CLLocation = locations.last!
            var str = "Location\n"
            str = str+"latitude:\(String(describing: location.coordinate.latitude))\n"
            str = str+"longitude:\(String(describing: location.coordinate.longitude))\n"
            str = str+"altitude:\(String(describing: location.altitude))\n"
            str = str+"horizontalAccuracy:\(String(describing: location.horizontalAccuracy))\n"
            str = str+"verticalAccuracy:\(String(describing: location.verticalAccuracy))\n"
            str = str+"course:\(String(describing: location.course))\n"
            str = str+"speed:\(String(describing: location.speed))\n"
            str = str+"timestamp:\(String(describing: location.timestamp))\n"
            str = str+"floor:\(String(describing: location.floor))\n"
            DispatchQueue.main.async {
                self.locationLbl.text = str
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager .startUpdatingLocation()
        }else if status == .authorizedAlways {
            locationManager .startUpdatingLocation()
        }
    }
}

