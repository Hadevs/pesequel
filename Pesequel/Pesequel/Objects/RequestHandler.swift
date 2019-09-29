//
//  RequestHandler.swift
//  allready-ios
//
//  Created by Hadevs on 17/09/2019.
//  Copyright © 2019 Ghost. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct RequestHandler {
  private let method: HTTPMethod
  private var path: String
  private var parameters: Parameters?
  private var jsonKeys: [String] = ["data"]
  private var baseUrl = Constants.baseUrl
  private var encoding: ParameterEncoding = JSONEncoding.default
  
  init(path: String, method: HTTPMethod = .get, parameters: Parameters? = nil) {
    self.method = method
    self.path = path
    self.parameters = parameters
  }
  
  func encoding(_ value: ParameterEncoding) -> RequestHandler {
    var new = self
    new.encoding = value
    return new
  }
  
  func jsonKey(_ value: String) -> RequestHandler {
    var new = self
    new.jsonKeys.append(value)
    return new
  }
  
  func newBaseURL(_ value: String) -> RequestHandler {
    var new = self
    new.baseUrl = value
    return new
  }
  
  @discardableResult
  func response<T: Codable>(_ closure: @escaping ItemClosure<T?>) -> RequestHandler {
    responseJSON { (json) in
      var finalJSON = json
      for key in self.jsonKeys {
        finalJSON = finalJSON[key]
      }
      
      let model = T.from(json: finalJSON)
      closure(model)
    }
    return self
  }
  
  @discardableResult
  func responseJSON(_ closure: @escaping ItemClosure<JSON>) -> RequestHandler {
    responseDataResponse { (response) in
      if let data = response.data, let json = try? JSON(data: data) {
        closure(json)
      } else {
        closure(JSON())
      }
    }
    return self
  }
  
  @discardableResult
  func responseDataResponse(_ closure: @escaping ItemClosure<DataResponse<Data>>) -> RequestHandler {
    let url = baseUrl + path
    let access: String? = KeychainManager.shared.fetchObject(by: "access")
    let request = Alamofire.request(url,
                      method: method,
                      parameters: parameters,
                      encoding: encoding,
                      headers: ["access": access ?? ""])
      
      request.responseData { (response) in
        if let data = response.data, let json = try? JSON(data: data), json["code"].string == "0013" {
          // token expiried
//          AuthManager.shared.refreshToken(with: AuthManager.shared.token ?? "") {
//            self.responseDataResponse(closure)
//          }
        } else {
          closure(response)
        }
    }
    return self
  }
}
