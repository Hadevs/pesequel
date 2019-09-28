//
//  MapViewController.swift
//  Pesequel
//
//  Created by Ghost on 27.09.2019.
//  Copyright © 2019 Ghost. All rights reserved.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController, GMSMapViewDelegate {
  @IBOutlet weak var mapView: GMSMapView!
  private let myMarker: DefaultMarker = {
    let marker = DefaultMarker(position: .init())
    marker.change(state: .active)
    return marker
  }()
  
  private var places: [Place] = []
  
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
    mapView.delegate = self
    myMarker.map = mapView
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    updateData()
  }
  
  private func updateData() {
    PlaceManager.shared.fetchPlaces { (places) in
      self.places = places
      self.reloadPins()
    }
  }
  
  private func reloadPins() {
    mapView.clear()
    for place in places {
      let marker = PlaceMarker(place: place)
      marker.map = mapView
    }
    myMarker.map = mapView
    if let location = LocationManager.shared.myLocation {
      self.myLocationUpdated(location)
    }
  }
  
  @IBAction func myLocationButtonClicked() {
    if let location = LocationManager.shared.myLocation {
      self.myLocationUpdated(location)
    }
  }
  
  func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
    let vc = PlaceViewController()
    navigationController?.pushViewController(vc, animated: true)
    return true
  }
  
  private func myLocationUpdated(_ location: CLLocation) {
    mapView.animate(toLocation: location.coordinate)
    mapView.animate(toZoom: 16)
    myMarker.position = location.coordinate
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
