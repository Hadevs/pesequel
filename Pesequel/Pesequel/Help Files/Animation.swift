//
//  Animation.swift
//  Pesequel
//
//  Created by Ghost on 27.09.2019.
//  Copyright © 2019 Ghost. All rights reserved.
//

import UIKit

class Animation {
  private init() {}
  private static let fastDuration: TimeInterval = 0.25
  private static func animate(_ closure: @escaping VoidClosure, duration: TimeInterval) {
    UIView.animate(withDuration: duration, animations: closure)
  }
  
  static func fast(_ closure: @escaping VoidClosure) {
    animate(closure, duration: fastDuration)
  }
}
