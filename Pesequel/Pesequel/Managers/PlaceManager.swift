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
    let url = Constants.baseUrl + "hubs"
    Alamofire.request(url)
      .fetchBodyJSON { (json) in
        closure([Place].from(json: json))
    } 
  }
}
