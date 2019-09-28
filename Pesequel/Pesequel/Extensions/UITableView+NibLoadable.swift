//
//  UITableView+NibLoadable.swift
//  Pesequel
//
//  Created by Ghost on 28.09.2019.
//  Copyright © 2019 Ghost. All rights reserved.
//

import UIKit

extension UITableView {
  func register<T: NibLoadable>(_ cellClass: T.Type) {
    register(cellClass.nib, forCellReuseIdentifier: cellClass.name)
  }
  
  func getCell<T: NibLoadable & UITableViewCell>(for indexPath: IndexPath) -> T {
    return dequeueReusableCell(withIdentifier: T.name, for: indexPath) as! T
  }
}
