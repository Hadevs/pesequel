//
//  AuthManager.swift
//  Pesequel
//
//  Created by Ghost on 29.09.2019.
//  Copyright © 2019 Ghost. All rights reserved.
//

import Foundation

class AuthManager {
  static let shared = AuthManager()
  private init() {}
  
  func send(codeTo phone: String, closure: @escaping VoidClosure) {
    RequestHandler(path: "send_code", method: .post, parameters: [
      "phoneNumber": phone.replacingOccurrences(of: " ", with: "").trimmingCharacters(in: .whitespaces)
      ])
      .responseJSON { (json) in
        closure()
    }
  }
  
  func confirmCode(with phone: String, code: String, _ closure: @escaping ItemClosure<Bool>) {
    RequestHandler(path: "confirm_code", method: .post, parameters: [
      "phoneNumber": phone.replacingOccurrences(of: " ", with: "").trimmingCharacters(in: .whitespaces),
      "code": code
      ]).responseJSON { (json) in
        let body = json["data"]
        
        if let access = body["access"].string, let refreshToken = body["refresh"].string {
          KeychainManager.shared.set(object: access, for: "access")
          KeychainManager.shared.set(object: refreshToken, for: "refresh")
          closure(true)
        } else {
          closure(false)
        }
    }
    
  }
  
}
