//
//  CartProduct.swift
//  Pesequel
//
//  Created by Ghost on 28.09.2019.
//  Copyright © 2019 Ghost. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

class CartProduct: Object, Codable {
  @objc dynamic var product: Product?
  @objc dynamic var amount: Int = 0
  
  static func == (lhs: CartProduct, rhs: CartProduct) -> Bool {
    return lhs.product == rhs.product
  }
}
