//
//  MapsTableViewCell.swift
//  Pesequel
//
//  Created by Ghost on 28.09.2019.
//  Copyright © 2019 Ghost. All rights reserved.
//

import UIKit
import GoogleMaps

class MapsTableViewCell: BasicTableViewCell, NibLoadable {
  @IBOutlet weak var mapView: GMSMapView!
  @IBOutlet weak var trcMapView: UIImageView!
  @IBOutlet weak var mapButton: UIButton!
  @IBOutlet weak var trcMapButton: UIButton!
  private var marker: PlaceMarker?
  
  func configure(by place: Place) {
    mapView.animate(toLocation: place.coordinate.coordinate)
    mapView.animate(toZoom: 16)
    configureMarker(by: place)
  }
  
  private func configureMarker(by place: Place) {
    if let marker = self.marker {
      marker.position = place.coordinate.coordinate
    } else {
      marker = PlaceMarker(place: place)
      marker?.map = mapView
    }
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    mapButton.round()
    trcMapButton.round()
    let radius: CGFloat = 42
    mapView.layer.cornerRadius = radius
    mapView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    trcMapView.layer.cornerRadius = radius
    trcMapView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
}
