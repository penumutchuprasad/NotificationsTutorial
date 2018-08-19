//CLService.swift
/*
 * LKNotificationTutorial
 * Created by penumutchu.prasad@gmail.com on 09/08/18
 * Is a product created by abnboys
 * For the LKNotificationTutorial in the LKNotificationTutorial
 
 * Here the permission is granted to this file with free of use anywhere in the IOS Projects.
 * Copyright © 2018 ABNBoys.com All rights reserved.
*/

import UIKit
import CoreLocation

class CLService: NSObject {
    
    private override init() {
        
    }
    
    static let shared = CLService()
    var locationManager = CLLocationManager()
    
    func requestLocationAuthorization() {
        
        locationManager.requestAlwaysAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self

        locationManager.startUpdatingLocation()
    }

    
    
}

extension CLService: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
            //Perform logic on change of status
            requestLocationAuthorization()
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        
        print("Show Notification")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        
    }
    
}
