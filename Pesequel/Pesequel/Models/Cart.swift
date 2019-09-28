//
//  Cart.swift
//  Pesequel
//
//  Created by Ghost on 28.09.2019.
//  Copyright © 2019 Ghost. All rights reserved.
//

import Foundation
import RealmSwift

final class Cart: Object {
  static var shared = Cart()
  @objc dynamic var id = ""
  @objc override class func primaryKey() -> String? { return "id" }
  var products: List<CartProduct> = List()
  @objc dynamic var currentCafe: Cafe?
  
  var totalPrice: Double {
    return products.reduce(0, { (result, product) -> Double in
      return Double(product.product?.price ?? "") ?? 0 + result
    })
  }
  
  var totalAmount: Int {
    return products.reduce(0, { (result, cartProduct) -> Int in
      return result + cartProduct.amount
    })
  }
  
  func amount(of product: Product) -> Int {
    return cartProduct(of: product)?.amount ?? 0
  }
  
  private func cartProduct(of product: Product) -> CartProduct? {
    for cartProduct in products where cartProduct.product?.uid == product.uid {
      return cartProduct
    }
    return nil
  }
  
  @discardableResult
  func remove(product: Product) -> Bool{
    let realm = try! Realm()
    var result = false
    if let product = cartProduct(of: product) {
      try? realm.write {
        product.amount -= 1
        if product.amount <= 0 {
          let inx = products.firstIndex(where: { (cartProduct) -> Bool in
            return cartProduct.product?.uid == product.product?.uid
          })
          if let index = inx {
            self.products.remove(at: index)
            result = true
          }
        }
      }
    }
    
    try? realm.write {
      realm.add(self, update: true)
    }
    return result
  }
  
  func fullyDelete(product: Product) {
    guard let cartProduct = cartProduct(of: product) else {
      return
    }
    
    for _ in 0..<cartProduct.amount {
      remove(product: product)
    }
  }
  
  func add(product: Product) {
    let realm = try! Realm()
    if let product = cartProduct(of: product) {
      try? realm.write {
        product.amount += 1
      }
    } else {
      let cartProduct = CartProduct()
      cartProduct.product = product
      cartProduct.amount = 1
      try? realm.write {
        products.append(cartProduct)
      }
    }
    
    try? realm.write {
      realm.add(self, update: true)
    }
  }
}
