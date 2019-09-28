//
//  BasicTableViewCEll.swift
//  Pesequel
//
//  Created by Ghost on 28.09.2019.
//  Copyright © 2019 Ghost. All rights reserved.
//

import UIKit

class BasicTableViewCell: UITableViewCell {
  override func didMoveToSuperview() {
    super.didMoveToSuperview()
    
    selectionStyle = .none
    separatorInset = UIEdgeInsets(top: 0, left: 15000, bottom: 0, right: 0)
  }
}
