//
//  UIView+RoundCorners.swift
//  Pesequel
//
//  Created by Ghost on 27.09.2019.
//  Copyright © 2019 Ghost. All rights reserved.
//

import UIKit

extension UIView {
  func roundCorners(corners: UIRectCorner, radius: CGFloat) {
    let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
    let mask = CAShapeLayer()
    mask.path = path.cgPath
    layer.mask = mask
  }
}
