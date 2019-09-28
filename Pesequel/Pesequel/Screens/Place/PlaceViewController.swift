//
//  PlaceViewController.swift
//  Pesequel
//
//  Created by Ghost on 28.09.2019.
//  Copyright © 2019 Ghost. All rights reserved.
//

import UIKit

class PlaceViewController: UIViewController {
  @IBOutlet weak var tableView: UITableView!
  enum SectionModel: CaseIterable {
    case info
    case cafe
    var rows: [CellModel] {
      switch self {
      case .info: return [.maps, .nameInfo, .orderTaxi]
      case .cafe: return [.cafes]
      }
    }
  }
  
  enum CellModel: CaseIterable {
    case maps
    case nameInfo
    case orderTaxi
    case cafes
  }
  
  private var place: Place?
  private var cafes: [Cafe] = []
  private let models: [SectionModel] = SectionModel.allCases
  
  convenience init(place: Place) {
    self.init()
    self.place = place
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.separatorColor = .clear
    tableView.register(DetailButtonTableViewCell.self)
    tableView.register(PlaceNameTableViewCell.self)
    tableView.register(MapsTableViewCell.self)
    tableView.register(CafesTableViewCell.self)
    tableView.delegate = self
    tableView.dataSource = self
    title = "Торговый центр"
    fetchCafes()
  }
  
  private func fetchCafes() {
    guard let place = self.place else {
      return
    }
    PlaceManager.shared.fetchCafes(in: place) { (cafes) in
      self.cafes = cafes
      self.tableView.reloadData()
    }
  }
}

extension PlaceViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    switch models[section] {
    case .info:
      return nil
    case .cafe:
      let headerView = RowDetailedTitleView.loadFromNib()
      let count = cafes.count
      headerView.rightLabel.text = "\(count)"
      return headerView
    }
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    switch models[section] {
    case .info:
      return 0
    case .cafe:
      return 66
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let model = models[indexPath.section].rows[indexPath.row]
    switch model {
    case .maps:
      let cell: MapsTableViewCell = tableView.getCell(for: indexPath)
      if let place = self.place {
        cell.configure(by: place)
      }
      return cell
    case .nameInfo:
      let cell: PlaceNameTableViewCell = tableView.getCell(for: indexPath)
      return cell
    case .orderTaxi:
      let cell: DetailButtonTableViewCell = tableView.getCell(for: indexPath)
      return cell
    case .cafes:
      let cell: CafesTableViewCell = tableView.getCell(for: indexPath)
      cell.cafes = cafes
      return cell
    }
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return models.count
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return models[section].rows.count
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    let model = models[indexPath.section].rows[indexPath.row]
    switch model {
    case .maps:
      return 220
    case .nameInfo:
      return 119
    case .orderTaxi:
      return 95
    case .cafes:
      return UITableView.automaticDimension
    }
  }
}
