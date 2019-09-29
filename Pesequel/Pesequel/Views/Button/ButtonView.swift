//
//  ButtonView.swift
//  Pesequel
//
//  Created by Ghost on 29.09.2019.
//  Copyright © 2019 Ghost. All rights reserved.
//

import UIKit

class ButtonView: UIView, NibLoadable {
  @IBOutlet weak var button: UIButton!
  
  override func didMoveToSuperview() {
    super.didMoveToSuperview()
    button.layer.cornerRadius = 10
  }
}
