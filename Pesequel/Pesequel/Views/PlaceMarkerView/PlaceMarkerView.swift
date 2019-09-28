//
//  PlaceMarkerView.swift
//  Pesequel
//
//  Created by Ghost on 28.09.2019.
//  Copyright © 2019 Ghost. All rights reserved.
//

import UIKit

class PlaceMarkerView: UIView, NibLoadable {
  @IBOutlet weak var backView: UIView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var subtitleLabel: UILabel!
  @IBOutlet weak var pinView: UIImageView!
  
  private let activeImage: UIImage? = UIImage(named: "pin-blue")
  private let inactiveImage: UIImage? = UIImage(named: "pin-gray")
  
  override func didMoveToSuperview() {
    super.didMoveToSuperview()
    backView.layer.shadowColor = UIColor.black.cgColor
    backView.layer.shadowOffset = CGSize(width: 0, height: 2)
    backView.layer.shadowOpacity = 0.08
    backView.layer.shadowRadius = 8
    backView.layer.cornerRadius = 8
  }
  
  func contentWidth() -> CGFloat {
    let contentValue = max(titleLabel.textWidth(), subtitleLabel.textWidth())
    return contentValue + 8 + 16 + 26
  }
  
  func configure(by state: PlaceMarker.State, and place: Place) {
    let image: UIImage? = {
      switch state {
      case .active: return activeImage
      case .deactive: return inactiveImage
      }
    }()
    pinView.image = image
    titleLabel.text = place.name
    subtitleLabel.text = "До \(place.close ?? "???")"
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    pinView.round()
  }
}
