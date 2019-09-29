//
//  ButtonTableViewCell.swift
//  Pesequel
//
//  Created by Ghost on 29.09.2019.
//  Copyright © 2019 Ghost. All rights reserved.
//

import UIKit

class ButtonTableViewCell: BasicTableViewCell, NibLoadable {
  
  @IBOutlet weak var button: UIButton!
  var buttonClicked: VoidClosure?
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
    button.layer.cornerRadius = 10
  }
  
  func setActivated(_ activated: Bool) {
    button.isEnabled = activated
    button.backgroundColor = activated ? #colorLiteral(red: 0, green: 0.4823529412, blue: 1, alpha: 1) : #colorLiteral(red: 0, green: 0.4823529412, blue: 1, alpha: 1).withAlphaComponent(0.16)
  }
  
  @IBAction func buttonAction() {
    buttonClicked?()
  }
}
