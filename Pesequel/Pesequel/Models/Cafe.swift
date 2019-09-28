//
//  Cafe.swift
//  Pesequel
//
//  Created by Ghost on 28.09.2019.
//  Copyright © 2019 Ghost. All rights reserved.
//

import Foundation

class Cafe: Codable {
  var uid: String?
  var name: String?
  var open: String?
  var close: String?
  var working_days: [String]?
  var located_at: Place?
  var cousine: [String]?
  var food: [String]?
  var average_price: String?
  var average_wait_time: String?
  var image: String?
}
