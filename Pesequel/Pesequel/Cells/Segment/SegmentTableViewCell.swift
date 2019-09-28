//
//  SegmentTableViewCell.swift
//  Pesequel
//
//  Created by Ghost on 29.09.2019.
//  Copyright © 2019 Ghost. All rights reserved.
//

import UIKit

class SegmentTableViewCell: BasicTableViewCell, NibLoadable {
  @IBOutlet weak var segmentControl: UISegmentedControl!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    segmentControl.round()
    segmentControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0, green: 0.4823529412, blue: 1, alpha: 1)], for: .normal)
    

    segmentControl.layer.borderColor = #colorLiteral(red: 0, green: 0.4823529412, blue: 1, alpha: 1).withAlphaComponent(0.15).cgColor
    segmentControl.tintColor = #colorLiteral(red: 0, green: 0.4823529412, blue: 1, alpha: 1).withAlphaComponent(0.15)
    segmentControl.layer.borderWidth = 1
    segmentControl.layer.masksToBounds = true
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
}
