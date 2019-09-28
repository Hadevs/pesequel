//
//  AlamofireRequest+JSON.swift
//  Pesequel
//
//  Created by Ghost on 28.09.2019.
//  Copyright © 2019 Ghost. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

extension DataRequest {
  func responseSwiftyJSON(_ closure: @escaping ItemClosure<JSON>) {
    responseData { (response) in
      let json = try? JSON(data: response.data ?? Data())
      closure(json ?? JSON())
    }
  }
  
  func fetchBodyJSON(_ closure: @escaping ItemClosure<JSON>) {
    responseSwiftyJSON { (json) in
      closure(json["data"])
    }
  }
}
