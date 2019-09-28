//
//  UserMarker.swift
//  Pesequel
//
//  Created by Ghost on 28.09.2019.
//  Copyright © 2019 Ghost. All rights reserved.
//

import UIKit
import GoogleMaps

class UserMarker: GMSMarker {
  func configure() {
    let imageView = UIImageView(image: UIImage.init(named: "db"))
    let size: CGFloat = 44
    imageView.frame.size = CGSize(width: size, height: size)
    imageView.layer.borderColor = UIColor.white.cgColor
    imageView.layer.borderWidth = 3
    imageView.layer.cornerRadius = size/2
    imageView.clipsToBounds = true
    iconView = imageView
  }
}
