//
//  Place.swift
//  Pesequel
//
//  Created by Ghost on 28.09.2019.
//  Copyright © 2019 Ghost. All rights reserved.
//

import Foundation
import CoreLocation

class Place: Codable {
  var uid: String?
  var name: String?
  var address: String?
  var open: String?
  var close: String?
  var working_days: [String]?
  var lat: String?
  var long: String?
  
  var coordinate: CLLocation {
    return CLLocation(latitude: Double(lat ?? "") ?? 0, longitude: Double(long ?? "") ?? 0)
  }
}
