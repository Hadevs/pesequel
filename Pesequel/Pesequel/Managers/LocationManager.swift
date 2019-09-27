//
//  LocationManager.swift
//  Pesequel
//
//  Created by Ghost on 27.09.2019.
//  Copyright © 2019 Ghost. All rights reserved.
//

import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {
  private override init() {
    super.init()
    locationManager.requestWhenInUseAuthorization()
    locationManager.startUpdatingLocation()
    locationManager.delegate = self
  }
  static let shared = LocationManager()
  
  private(set) var myLocation: CLLocation? = nil {
    didSet {
      locationUpdated?()
    }
  }
  private let locationManager = CLLocationManager()
  var locationUpdated: VoidClosure?
  
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    myLocation = locations.first
  }
}
