//
//  Decodable+JSON.swift
//  Pesequel
//
//  Created by Ghost on 28.09.2019.
//  Copyright © 2019 Ghost. All rights reserved.
//

import Foundation
import SwiftyJSON

extension Decodable {
  static func from(json: JSON) -> Self {
    return try! JSONDecoder().decode(Self.self, from: (try? json.rawData()) ?? Data())
  }
}
