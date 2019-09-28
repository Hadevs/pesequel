//
//  LabelTableViewCell.swift
//  Pesequel
//
//  Created by Ghost on 29.09.2019.
//  Copyright © 2019 Ghost. All rights reserved.
//

import UIKit

class LabelTableViewCell: BasicTableViewCell, NibLoadable {
  @IBOutlet weak var label: UILabel!
  override func awakeFromNib() {
    super.awakeFromNib()
    label.text = "Вы можете оплатить заказ при получение, если сумма заказа не превышает 1 000 ₽"
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
}
