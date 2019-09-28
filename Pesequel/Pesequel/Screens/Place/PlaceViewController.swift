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
  enum CellModel: CaseIterable {
    case maps
    case nameInfo
    case orderTaxi
  }
  
  private let models: [CellModel] = CellModel.allCases
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.register(DetailButtonTableViewCell.self)
    tableView.register(PlaceNameTableViewCell.self)
    tableView.register(MapsTableViewCell.self)
    tableView.delegate = self
    tableView.dataSource = self
    title = "Торговый центр"
  }
}

extension PlaceViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let model = models[indexPath.row]
    switch model {
    case .maps:
      let cell: MapsTableViewCell = tableView.getCell(for: indexPath)
      return cell
    case .nameInfo:
      let cell: PlaceNameTableViewCell = tableView.getCell(for: indexPath)
      return cell
    case .orderTaxi:
      let cell: DetailButtonTableViewCell = tableView.getCell(for: indexPath)
      return cell
    }
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return models.count
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    let model = models[indexPath.row]
    switch model {
    case .maps:
      return 220
    case .nameInfo:
      return 119
    case .orderTaxi:
      return 95
    }
  }
}
