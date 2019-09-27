//
//  MapViewController.swift
//  Pesequel
//
//  Created by Ghost on 27.09.2019.
//  Copyright © 2019 Ghost. All rights reserved.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController {
  @IBOutlet weak var mapView: GMSMapView!
  private let myMarker: GMSMarker = {
    let marker = GMSMarker(position: .init())
    return marker
  }()
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Торговые центры"
    NavigationBarDecorator(self).decorate()
    addLeftBarButtonItem()
    LocationManager.shared.locationUpdated = {
      if let location = LocationManager.shared.myLocation {
        self.myLocationUpdated(location)
      }
    }
  }
  
  @IBAction func myLocationButtonClicked() {
    if let location = LocationManager.shared.myLocation {
      self.myLocationUpdated(location)
    }
  }
  
  private func myLocationUpdated(_ location: CLLocation) {
    mapView.animate(toLocation: location.coordinate)
    mapView.animate(toZoom: 16)
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    mapView.roundCorners(corners: [.topLeft, .topRight], radius: 42)
  }
  
  private func addLeftBarButtonItem() {
    let button = UIButton()
    button.widthAnchor.constraint(equalToConstant: 36).isActive = true
    button.heightAnchor.constraint(equalToConstant: 36).isActive = true
    button.layer.cornerRadius = 36/2
    button.layer.masksToBounds = true
    button.setImage(UIImage(named: "db"), for: .normal)
    let barButton = UIBarButtonItem(customView: button)
    navigationItem.leftBarButtonItem = barButton
  }
  
    
}
