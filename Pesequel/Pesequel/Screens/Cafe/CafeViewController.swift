//
//  CafeViewController.swift
//  Pesequel
//
//  Created by Ghost on 28.09.2019.
//  Copyright © 2019 Ghost. All rights reserved.
//

import UIKit

class CafeViewController: UIViewController {
  enum SectionModel: CaseIterable {
    case info
    case products
    
    var rows: [CellModel] {
      switch self {
      case .info: return [.info, .orderTaxi]
      case .products: return [.products]
      }
    }
  }
  enum CellModel {
    case info
    case orderTaxi
    case products
  }
  private var cafe: Cafe?
  
  convenience init(cafe: Cafe) {
    self.init()
    self.cafe = cafe
  }
  
  private let sectionModels = SectionModel.allCases
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
  }
}

extension CafeViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let model = sectionModels[indexPath.section].rows[indexPath.row]
    switch model {
    case .orderTaxi:
      let cell: DetailButtonTableViewCell = tableView.getCell(for: indexPath)
      return cell
    case .info:
      let cell: CafeInfoTableViewCell = tableView.getCell(for: indexPath)
      if let cafe = self.cafe {
        cell.configure(by: cafe)
      }
      return cell
    case .products:
      
    }
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    let model = sectionModels[indexPath.section].rows[indexPath.row]
    switch model {
    case .orderTaxi: return 95
    case .info: return 75
    }
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    let sectionModel = sectionModels[section]
    return sectionModel.rows.count
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return sectionModels.count
  }
}
