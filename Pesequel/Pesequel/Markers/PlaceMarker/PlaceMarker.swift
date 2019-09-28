//
//  PlaceMarker.swift
//  Pesequel
//
//  Created by Ghost on 28.09.2019.
//  Copyright © 2019 Ghost. All rights reserved.
//

import UIKit
import GoogleMaps

class PlaceMarker: GMSMarker {
  enum State {
    case active
    case deactive
  }
  private let activeImage: UIImage? = UIImage(named: "pin-blue")
  private let inactiveImage: UIImage? = UIImage(named: "pin-gray")
  private(set) var place: Place?
  convenience init(place: Place) {
    self.init(position: place.coordinate.coordinate)
    self.place = place
    change(state: .active)
  }
  
  func change(state: State) {
    iconView = iconView(by: state)
  }
  
  private func iconView(by state: State) -> UIView {
    let iconView = PlaceMarkerView.loadFromNib()
    if let place = place {
      iconView.configure(by: state, and: place)
    }
    
    iconView.frame.size = CGSize(width: iconView.contentWidth(), height: 50)
    return iconView
  }
}
