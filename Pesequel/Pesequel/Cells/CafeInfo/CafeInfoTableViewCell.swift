//
//  CafeInfoTableViewCell.swift
//  Pesequel
//
//  Created by Ghost on 28.09.2019.
//  Copyright © 2019 Ghost. All rights reserved.
//

import UIKit

class CafeInfoTableViewCell: UITableViewCell, NibLoadable {
  @IBOutlet weak var photoView: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var subtitleLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    photoView.layer.cornerRadius = 6
    photoView.clipsToBounds = true
  }
  
  func configure(by cafe: Cafe) {
    ImageLoader(photoView).load(cafe)
    titleLabel.text = cafe.name
    let subtitle = "Работает до \(cafe.close ?? "") - 3 этаж"
    subtitleLabel.text = subtitle
  }
}
