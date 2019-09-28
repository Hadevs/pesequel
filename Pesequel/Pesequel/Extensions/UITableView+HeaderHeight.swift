//
//  UITableView+HeaderHeight.swift
//  Pesequel
//
//  Created by Ghost on 28.09.2019.
//  Copyright © 2019 Ghost. All rights reserved.
//

import UIKit

extension UITableView {
  func updateHeaderViewHeight() {
    if let header = self.tableHeaderView {
      let newSize = header.systemLayoutSizeFitting(CGSize(width: self.bounds.width, height: 0))
      header.frame.size.height = newSize.height
      header.frame.size.width = frame.width
    }
  }
}
