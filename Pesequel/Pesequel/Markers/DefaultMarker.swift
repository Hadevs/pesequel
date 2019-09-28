//
//  DefaultMarker.swift
//  Pesequel
//
//  Created by Ghost on 28.09.2019.
//  Copyright © 2019 Ghost. All rights reserved.
//

import UIKit
import GoogleMaps

class DefaultMarker: GMSMarker {
  enum State {
    case active
    case deactive
  }
  private let activeImage: UIImage? = UIImage(named: "pin-blue")
  private let inactiveImage: UIImage? = UIImage(named: "pin-gray")
  
  func change(state: State) {
    iconView = iconView(by: state)
  }
  
  private func iconView(by state: State) -> UIView {
    let image: UIImage? = {
      switch state {
      case .active: return activeImage
      case .deactive: return inactiveImage
      }
    }()
    let sizeValue: CGFloat = 22
    let iconView = UIImageView(image: image)
    iconView.contentMode = .scaleAspectFit
    iconView.frame.size = CGSize(width: sizeValue, height: sizeValue)
    iconView.layer.cornerRadius = sizeValue / 2
    iconView.clipsToBounds = true
    return iconView
  }
}
