//
//  KeychainManager.swift
//  allready-ios
//
//  Created by Ghost on 08.07.2019.
//  Copyright © 2019 Ghost. All rights reserved.
//

import Foundation
import Locksmith

class KeychainManager {
  typealias Object = Any
  typealias Key = String
  private init() {}
  private let userAccount = "default"
  
  static let shared = KeychainManager()
  
  func set(object: Object, for key: Key) {
    var currentData = Locksmith.loadDataForUserAccount(userAccount: userAccount) ?? [:]
    currentData[key] = object
    do {
      try Locksmith.updateData(data: currentData, forUserAccount: userAccount)
    } catch {
      print(error)
    }
  }
  
  var isAuthorized: Bool {
    let token: String? = fetchObject(by: "access")
    return token != nil
  }
  
  func fetchObject<T>(by key: String) -> T? {
    let currentData = Locksmith.loadDataForUserAccount(userAccount: userAccount) ?? [:]
    return currentData[key] as? T
  }
  
  func clear() {
    try? Locksmith.deleteDataForUserAccount(userAccount: userAccount)
  }
}
