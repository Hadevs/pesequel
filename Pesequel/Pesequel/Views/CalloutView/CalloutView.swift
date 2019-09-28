//
//  CalloutView.swift
//  Pesequel
//
//  Created by Ghost on 28.09.2019.
//  Copyright © 2019 Ghost. All rights reserved.
//

import UIKit

class CalloutView: UIView, NibLoadable {
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var subtitleLabel: UILabel!
  
  override func didMoveToSuperview() {
    super.didMoveToSuperview()
    layer.shadowColor = UIColor.black.cgColor
    layer.shadowOffset = CGSize(width: 0, height: 2)
    layer.shadowOpacity = 0.08
    layer.shadowRadius = 8
    layer.cornerRadius = 8
  }
}
