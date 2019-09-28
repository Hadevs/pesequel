//
//  Product.swift
//  Pesequel
//
//  Created by Ghost on 28.09.2019.
//  Copyright © 2019 Ghost. All rights reserved.
//

import Foundation
import RealmSwift

final class Product: Object, Codable {
  @objc dynamic var uid: String?
  @objc dynamic var name: String?
  @objc dynamic var mass: String?
  @objc dynamic var image: String?
  @objc dynamic var price: String?
  @objc dynamic var category: String?
  
  static func == (lhs: Product, rhs: Product) -> Bool {
    return lhs.uid == rhs.uid
  }
}

