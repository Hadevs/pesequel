//
//  PlaceManager.swift
//  Pesequel
//
//  Created by Ghost on 28.09.2019.
//  Copyright © 2019 Ghost. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class PlaceManager {
  private init() {}
  static let shared = PlaceManager()
  
  func fetchPlaces(_ closure: @escaping ItemClosure<[Place]>) {
    RequestHandler(path: "hubs")
      .response { (model: [Place]?) in
        closure(model ?? [])
    }
  }
  
  func fetchCafes(in hub: Place, _ closure: @escaping ItemClosure<[Cafe]>) {
    RequestHandler(path: "places/\(hub.uid ?? "")")
      .response { (model: [Cafe]?) in
        closure(model ?? [])
    }
  }
  
  func postOrder(orderRequest: NewOrderRequest, _ closure: @escaping ItemClosure<String?>) {
    let dict = orderRequest.ordered.map {$0.dictionary ?? [:]}
    let parameters: Parameters = ["refplace": orderRequest.refplace ?? "",
                      "refuser": orderRequest.refuser ?? "",
                      "ordered": dict,
                      "pick_up_type": orderRequest.pick_up_type ?? "",
                      "to_be_ready_at": orderRequest.to_be_ready_at ?? ""]
    RequestHandler(path: "new_order", method: .post, parameters: parameters)
      .responseJSON { (json) in
        closure(json["error"].string)
    }
  }
}
