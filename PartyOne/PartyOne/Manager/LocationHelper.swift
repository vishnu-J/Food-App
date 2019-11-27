//
//  LocationHelper.swift
//  Zomato
//
//  Created by Vishnu on 26/11/19.
//  Copyright © 2019 GreedyGame. All rights reserved.
//

import Foundation
import CoreLocation

open class LocationHelper : NSObject{
    
    public typealias LOCATION_DELEGATE = (_ location: CLLocation?, _ errro: String?) -> Void
    private static let TAG = "LocHlpr"
    
    private var locationManager  : CLLocationManager?
    
    var result: LOCATION_DELEGATE?
    
    public override init() {
        super.init()
    }
    
    public func getLocation(onLocation result: @escaping LOCATION_DELEGATE) {
        self.result = result
        if !CLLocationManager.locationServicesEnabled() {
            Logger.d(LocationHelper.TAG, "[ERROR] Location service not enabled.")
            result(nil, "Location service not enabled")
            return
        }
        
        Logger.d(LocationHelper.TAG, "Location service enabled")
        
        let status = CLLocationManager.authorizationStatus()
        switch status {
        case .denied, .notDetermined, .restricted:
            Logger.d(LocationHelper.TAG, "[ERROR] Not able to access the location. \(status.rawValue)")
            result(nil, "Location service enabled but not able to access the location")
            return
        case .authorizedAlways, .authorizedWhenInUse:
            // Waiting for location delegate to fetch the location
            locationManager = CLLocationManager()
            guard locationManager != nil else {
                result(nil, "Location service enabled but couldnt create locManager instance")
                return
            }
            locationManager?.delegate = self
            locationManager?.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            if #available(iOS 9.0, *) {
                locationManager?.requestLocation()
            } else {
                // Fallback on earlier versions
                locationManager?.requestWhenInUseAuthorization()
                locationManager?.requestAlwaysAuthorization()
            }
            return
        }
    }
}

extension LocationHelper : CLLocationManagerDelegate {
    
    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        Logger.d(LocationHelper.TAG, "Location autorization status \(status.rawValue)")
    }
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // the most recent location is present at the end of the array.
        guard let location = locations.last else {
            Logger.d(LocationHelper.TAG, "[ERROR] Received Empty Location")
            self.result!(nil, "Received empty Location")
            return
        }
        self.result!(location, nil)
    }
    
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        Logger.d(LocationHelper.TAG, "Location failed")
        self.result!(nil, error.localizedDescription)
    }
    
}
