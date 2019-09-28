//
//  Cafe.swift
//  Pesequel
//
//  Created by Ghost on 28.09.2019.
//  Copyright © 2019 Ghost. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

@objc class Cafe: Object, Codable {
  @objc dynamic var uid: String?
  @objc dynamic var name: String?
  @objc dynamic var open: String?
  @objc dynamic var close: String?
  var working_days: List<String>?
  @objc dynamic var located_at: Place?
  var cousine: List<String>?
  var food: List<Product>?
  @objc dynamic var average_price: String?
  @objc dynamic var average_wait_time: String?
  @objc dynamic var image: String?
}
