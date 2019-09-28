//
//  DetailButtonTableViewCell.swift
//  Pesequel
//
//  Created by Ghost on 28.09.2019.
//  Copyright © 2019 Ghost. All rights reserved.
//

import UIKit

class DetailButtonTableViewCell: BasicTableViewCell, NibLoadable {
  
  @IBOutlet weak var backView: UIView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    backView.layer.shadowColor = UIColor.black.cgColor
    backView.layer.shadowOffset = CGSize(width: 0, height: 4)
    backView.layer.shadowRadius = 14
    backView.layer.shadowOpacity = 0.06
    backView.layer.cornerRadius = 10
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
}
