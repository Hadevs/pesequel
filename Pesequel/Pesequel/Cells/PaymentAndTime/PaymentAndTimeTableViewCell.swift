//
//  PaymentAndTimeTableViewCell.swift
//  Pesequel
//
//  Created by Ghost on 29.09.2019.
//  Copyright © 2019 Ghost. All rights reserved.
//

import UIKit

class PaymentAndTimeTableViewCell: BasicTableViewCell, NibLoadable {
  @IBOutlet weak var timeLabel: UILabel!
  @IBOutlet weak var paymentLabel: UILabel!
  
  var timeClicked: VoidClosure?
  var paymentClicked: VoidClosure?
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  @IBAction func paymentButtonClicked() {
    paymentClicked?()
  }
  
  @IBAction func timeButtonClicked() {
    timeClicked?()
  }
}
