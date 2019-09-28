//
//  UIView+Round.swift
//  Pesequel
//
//  Created by Ghost on 28.09.2019.
//  Copyright © 2019 Ghost. All rights reserved.
//

import UIKit

extension UIView {
  func round() {
    layer.cornerRadius = frame.height / 2
  }
}
