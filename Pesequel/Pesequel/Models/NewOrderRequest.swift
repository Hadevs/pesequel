//
//  NewOrderRequest.swift
//  Pesequel
//
//  Created by Ghost on 29.09.2019.
//  Copyright © 2019 Ghost. All rights reserved.
//

import Foundation

struct NewOrderRequest {
  var refplace: String? // place uid
  var refuser: String?
  var ordered: [CartProduct] = []
  var pick_up_type: String?
  var to_be_ready_at: String?
  
  var isFilled: Bool {
    return
      refplace != nil
      && ordered != nil
      && pick_up_type != nil
      && to_be_ready_at != nil
  }
}
