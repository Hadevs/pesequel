//
//  Place.swift
//  Pesequel
//
//  Created by Ghost on 28.09.2019.
//  Copyright © 2019 Ghost. All rights reserved.
//

import Foundation
import CoreLocation
import RealmSwift
import Realm

final class Place: Object, Codable {
  @objc dynamic var uid: String?
  @objc dynamic var name: String?
  @objc dynamic var address: String?
  @objc dynamic var open: String?
  @objc dynamic var close: String?
  var working_days: List<String>?
  @objc dynamic var lat: String?
  @objc dynamic var long: String?
  
  var coordinate: CLLocation {
    return CLLocation(latitude: Double(lat ?? "") ?? 0, longitude: Double(long ?? "") ?? 0)
  }
}
